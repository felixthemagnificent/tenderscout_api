class Scrapers::BuyAndSellJob < ApplicationJob
  queue_as :scrapers

  def perform
    Chewy.strategy(:atomic) do
      ScraperLink.where(status: :pending, worker_name: 'buy_and_sell').each do |link|
        extract_tender(link.link)
        link.done!
      end
    end
  end

  def extract_tender(link)
    Core::Tender.transaction do
      tender_information = {}
      content = get_content(link)
      doc = Nokogiri::HTML(content)
      submission_date = doc.xpath('//*[text()="Date closing"]/../following-sibling::dd[1]//text()').text
      tmp = submission_date.split("\b\d{4}/\d[01-12]/\d[01-31]\s\d[01-24]:\d[0-59]\b")
      if tmp.count == 0
        tmp = submission_date.split
        submission_date = "#{tmp[0]} + #{tmp[1]}"
      else
        submission_date = tmp[0]
      end
      tender_information[:spider_id] = doc.xpath('//dd[@class="data solicitation-number"]//text()').text
      tender_information[:title] = doc.xpath('//h1[@id="cont"]/text()').text
      tender_information[:organization_name] = doc.xpath('//*[text()="Procurement entity"]/../following-sibling::dd[1]//text()')
      tender_information[:location] = doc.xpath('//*[text()="Contact address"]/../following-sibling::dd[1]//text()')
      tender_information[:country_name] = 'United States'
      tender_information[:published_on] = doc.xpath('//dd[@class="data publication-date"]/span/text()').text.strip
      tender_information[:submission_date] = submission_date
      tender_information[:description] = doc.xpath('//div[@class="field-content tender_description"]//text()').text.strip
      tender_information[:buyer] = tender_information[:organization_name]

      tender_information[:contact_point] = doc.xpath('//*[text()="Contact name"]/../following-sibling::dd[1]//text()').text
      tender_information[:email] = doc.xpath('//*[text()="Contact email"]/../following-sibling::dd[1]//text()').text
      tender_information[:phone] = doc.xpath('//*[text()="Contact phone"]/../following-sibling::dd[1]//text()').text

      tender_hash = tender_information.slice(*tender_keys)
      tender_hash[:tender_urls] = [link]
      tender_hash[:spider_id] = Digest::SHA512.hexdigest(tender_hash[:spider_id] + link)

      org_hash = tender_information.slice(*organization_keys)

      organization = Core::Organization.find_or_initialize_by name: org_hash[:name]
      if organization.new_record?
        organization.country = Core::Country.find_by_name org_hash[:country_name]
        organization.address = doc.xpath('//*[text()="Contact address"]/../following-sibling::dd[1]//text()').text
        raise 'Invalid country!' unless a.country
        organization.save!
      end
      tender = Core::Tender.find_or_initialize_by(spider_id: tender_hash[:spider_id])
      tender.attributes = tender_hash
      tender.organization = organization
      tender.save!
      tender.contacts.create(
        contact_point: tender_information[:contact_point],
        email: tender_information[:email],
        phone: tender_information[:phone]
      )
    end
  end


  def get_content(url)
    open(url,'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
                  "Accept"    => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                  "Accept-Language" => 'en-US,en;q=0.5') { |io| io.read }
  end

  def organization_keys
    [:name, :country_name]
  end

  def tender_keys
    [:spider_id, :title, :description, :published_on, :submission_datetime, :tender_urls]
  end
end
