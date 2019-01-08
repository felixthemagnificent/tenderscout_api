class Scrapers::FboGovJob < ApplicationJob
  queue_as :scrapers


  def perform
    Chewy.strategy(:atomic) do
      fetch_links
      ScraperLink.where(status: :pending, worker_name: 'fbo_gov').each do |link|
        extract_tender(link.link)
        link.done!
      end
    end
  end

  def fetch_links
    current_page = 1
    next_page_available = true
    while next_page_available
      mainURL = 'https://www.fbo.gov/index.php?s=opportunity&mode=list&tab=list&tabmode=list&pp=100&pageID=' + current_page.to_s
      content = get_content(mainURL)
      doc = Nokogiri::HTML(content)
      links = doc.css('table.list').children.css('tr').map { |e| "https://www.fbo.gov/index.php" + e.css('a').first.attributes['href'] }
      links.shift
      links.each do |link|
        a = ScraperLink.find_or_initialize_by link: link, worker_name: 'fbo_gov'
        a.pending! unless a.done?
      end
      current_page += 1
      puts current_page
      next_page_available = false unless content.include?('title="page ' + current_page.to_s + '"')
    end
  end

  def extract_tender(link)
    Core::Tender.transaction do
      tender_information = {}
      content = get_content(link)
      doc = Nokogiri::HTML(content)
      tender_information[:spider_id] = (doc.css('div.sol-num').first.text.split.third rescue "") || ""
      tender_information[:title] = (doc.css('div.agency-header').css('h2').text rescue "") || ""
      tender_information[:organization_name] = (doc.css('div.agency-name').children.first.text[8..-1] rescue "") || ""
      tender_information[:location] = (doc.css('div.agency-name').children[4].text[10..-1] rescue "") || ""
      tender_information[:country_name] = 'United States'
      tender_information[:created_at] = tender_information[:updated_at] = (doc.css('div#dnf_class_values_procurement_notice__original_posted_date__widget').text.strip rescue "") || ""
      tender_information[:published_at] = (doc.css('div#dnf_class_values_procurement_notice__posted_date__widget').text.strip rescue "") || ""
      tender_information[:cpv_codes] = (doc.css('div#dnf_class_values_procurement_notice__classification_code__widget').text.strip rescue "") || ""
      tender_information[:submission_date] = (doc.css('div#dnf_class_values_procurement_notice__response_deadline__widget').text.strip rescue "") || ""
      tender_information[:naics] = (doc.css('div#dnf_class_values_procurement_notice__naics_code__widget').text.strip rescue "") || ""
      tender_information[:description] = (doc.css('div#dnf_class_values_procurement_notice__description__widget').text.strip rescue "") || ""
      tender_information[:buyer] = tender_information[:organization_name]

      if content.include?('>Primary Point of Contact.')
        contact_info = (doc.css('div.fld_primary_poc').css('div.widget').css('div').first.text.split("\t")  rescue "") || ""
        tender_information[:contact_point] = contact_info[2][0..-3]
        tender_information[:email] = contact_info[4][0..-2]
        tender_information[:phone] = contact_info[5][7..-1]
      end


      tender_hash = tender_information.slice(*tender_keys)
      tender_hash[:tender_urls] = [link]
      tender_hash[:spider_id] = Digest::SHA512.hexdigest(tender_hash[:spider_id] + link)

      org_hash = tender_information.slice(*organization_keys)

      organization = Core::Organization.find_or_initialize_by name: org_hash[:name]
      if organization.new_record?
        organization.country = Core::Country.find_by_name org_hash[:country_name]
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
    open(url,'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Firefox/31.0',
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
