class Scrapers::EbrdJob < ApplicationJob
  queue_as :scrapers

  def perform
    Chewy.strategy(:atomic) do
      ScraperLink.where(status: :pending, worker_name: 'ebrd').each do |link|
        extract_tender(link.link)
        link.done!
      end
    end
  end

  def extract_tender(link)
    Core::Tender.transaction do
      tender_information = {}
      content = get_content(link)
      response = Nokogiri::HTML(content)
      
      description = [response.xpath('/html/body/div[4]/div/div/div[1]/article/p[1]//text()').text, response.xpath('/html/body/div[4]/div/div/div[1]/article/p[2]//text()').text].compact.join("\n")
      tender_information[:spider_id] = response.xpath('//*[contains(text(),"Project number:")]/following-sibling::p[1]/text()').text
      tender_information[:title] = response.xpath('/html/body/div[4]/div/div/div[1]/h1/text()').text
      tender_information[:organization_name] = 'EBRD'
      # tender_information[:location] = doc.xpath('//*[text()="Contact address"]/../following-sibling::dd[1]//text()')
      tender_information[:country_name] = response.xpath('//*[contains(text(),"Location:")]/following-sibling::p[1]/text()').text
      tender_information[:published_on] = response.xpath('//*[contains(text(),"Issue date:")]/following-sibling::p[1]/text()').text
      tender_information[:submission_date] = DateTime.try(:parse, response.xpath('//*[contains(text(),"Closing date:")]/following-sibling::p[1]/text()').text)
      tender_information[:description] = description.strip
      tender_information[:buyer] = tender_information[:organization_name]

      # tender_information[:contact_point] = doc.xpath('//*[text()="Contact name"]/../following-sibling::dd[1]//text()').text
      # tender_information[:email] = doc.xpath('//*[text()="Contact email"]/../following-sibling::dd[1]//text()').text
      # tender_information[:phone] = doc.xpath('//*[text()="Contact phone"]/../following-sibling::dd[1]//text()').text

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
      # tender.contacts.create(
      #   contact_point: tender_information[:contact_point],
      #   email: tender_information[:email],
      #   phone: tender_information[:phone]
      # )
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
