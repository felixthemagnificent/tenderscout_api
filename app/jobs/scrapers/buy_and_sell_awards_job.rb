class Scrapers::BuyAndSellAwardsJob < ApplicationJob
  queue_as :scrapers

  def perform
    Chewy.strategy(:atomic) do
      fetch_links
      ScraperLink.where(status: :pending, worker_name: 'buy_and_sell_awards') do |link|
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
      tender_information[:title] = doc.xpath('//*[text()="Solicitation number"]/../following::dd[1]//text()').text
      tender_information[:organization_name] = doc.xpath('//*[text()="Procurement entity"]/../following-sibling::dd[1]//text()')
      tender_information[:location] = doc.xpath('//*[text()="Contact address"]/../following-sibling::dd[1]//text()')
      tender_information[:country_name] = 'Canada'
      tender_information[:published_at] = doc.xpath('//*[text()="Publication date"]/../following::dd[1]//text()').text.strip
      tender_information[:submission_date] = submission_date
      tender_information[:description] = doc.xpath('//div[@class="field-content tender_description"]//text()').text.strip
      tender_information[:buyer] = tender_information[:organization_name]
      tender_information[:awarded_on] = doc.xpath('//*[text()="Contract award date"]/../following::dd[1]//text()').text
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

  def fetch_links
    next_page_available = true
    next_page_link =  "https://buyandsell.gc.ca/procurement-data/search/site?f%5B0%5D=sm_facet_procurement_data%3Adata_data_tender_award"
    while next_page_available
      content = get_content(next_page_link)
      doc = Nokogiri::HTML(content)
      links = doc.xpath("//ul[@class='search-results']/li").map{ |e| e.xpath('./div/h2/a/@href').text }
      links.each do |link|
        a = ScraperLink.find_or_initialize_by link: link, worker_name: 'buy_and_sell_awards'
        a.pending! unless a.done?
      end
      next_page_link = doc.xpath("//a[@title='Go to next page']/@href").text
      next_page_available = false unless content.include?('Go to next page')
    end
  end

  def get_content(url)
    open(url,'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
                  "Accept"    => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
                  "Accept-Language" => 'en-US,en;q=0.5') { |io| io.read }
  end

  def main_urls
    ['https://buyandsell.gc.ca/procurement-data/search/site?f%5B0%5D=sm_facet_procurement_data%3Adata_data_tender_notice&f%5B1%5D=ss_publishing_status%3ASDS-SS-005',
                'https://buyandsell.gc.ca/procurement-data/search/site?f%5B0%5D=sm_facet_procurement_data%3Adata_data_tender_notice&f%5B1%5D=ss_publishing_status%3ASDS-SS-006']
  end
end
