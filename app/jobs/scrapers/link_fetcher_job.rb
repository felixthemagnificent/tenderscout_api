class Scrapers::LinkFetcherJob < ApplicationJob
  queue_as :scrapers

  def perform
    fbo_fetch_links
    buy_and_sell_fetch_links
    buy_and_sell_awards_fetch_links
    ebrd_fetch_links
    contract_finder_fetch_links
    etenders_fetch_links

    Scrapers::LinkFetcherJob.perform_later
  end

  private

  def udbud_fetch_links
    root_url = 'https://www.udbud.dk/'.freeze
    field_names = {
      tender_type: 'ctl00$ctl00$ContentPlaceHolderMain$ContentPlaceHolderContent$TseFrontPage$DdlTenderType',
      search_button: 'ctl00$ctl00$ContentPlaceHolderMain$ContentPlaceHolderContent$TseFrontPage$BtnSearch',
    }.freeze
    agent = Mechanize.new {|a| a.ssl_version, a.verify_mode = 'SSLv3', OpenSSL::SSL::VERIFY_NONE}
    agent.user_agent_alias = 'Mac Safari'
    home = agent.get(root_url)
    form = home.form
    form[field_names[:tender_type]] = 'National'
    page = form.submit(form.button_with(name: field_names[:search_button]))
    links = page.links.select{|l| /ShowTender/ =~ l.href }.map(&:href).map { |e| root_url + e  }
    links.each do |link|
      a = ScraperLink.find_or_initialize_by link: link, worker_name: 'udbud'
      a.pending! unless a.done?
    end
  end


  def etenders_fetch_links
    root_url = ''
    field_names = {
      sort_by: 'SearchFilter.SortField',
      sort_direction: 'SearchFilter.SortDirection',
      name_query: 'SearchFilter.ShortDescription',
      reference_query: 'SearchFilter.Reference',
      id_query: 'SearchFilter.TenderId',
      operator_id: 'SearchFilter.OperatorId',
      branding: 'Branding',
      category_id: 'SavedCategoryId',
      unit_name: 'SavedUnitAndName',
      notice_type: 'SearchFilter.PublishType', # 1 => tenders, 2 => awards
      query: 'TextFilter',
      published_from: 'SearchFilter.FromDate',
      published_to: 'SearchFilter.ToDate',
      include_closed: 'SearchFilter.ShowExpiredRft',
      page_number: 'SearchFilter.PagingInfo.PageNumber',
      page_size: 'SearchFilter.PagingInfo.PageSize',
    }

    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    home = agent.get("https://irl.eu-supply.com/ctm/Supplier/PublicTenders")
    options = {
      page_size: 1000,
      include_closed: true,
      notice_type: 1,
      sort_by: 'PublicationDate',
      sort_direction: 'Desc'
    }
    # award_links = []
    # loop.with_index do |_, i|
    #   form = @home.form
    #   options.merge(notice_type: 2,page_number: i+1).each do |key, value|
    #     form[FIELD_NAMES[key]] = value
    #   end
    #   results_page = form.submit(form.button_with(id: 'search'))
    #   page_links = results_page.links.select{|l| /app\/rfq\/.*\.asp.*PID=\d*&PP=/ =~ l.href }
    #   break if page_links.size == 0
    #   award_links += page_links
    # end
    # award_link_hash = award_links.flat_map{ |page|
    #   page.map{ |al|
    #     [al.href.match(/PID=(\d*)/)[1], hostify(al.href, @home)]
    #   }
    # }.to_h

    loop.with_index do |_, i|
      form = home.form
      options.merge(notice_type: 2,page_number: i+1).each do |key, value|
        form[field_names[key]] = value
      end
      results_page = form.submit(form.button_with(id: 'search'))
      page_links = results_page.links.select{|l| /app\/rfq\/.*\.asp.*PID=\d*&PP=/ =~ l.href }
      break if page_links.size == 0
      page_links.map(&:href).each do |link|
        link = "https://irl.eu-supply.com/#{link}"
        a = ScraperLink.find_or_initialize_by link: link, worker_name: 'etender'
        a.pending! unless a.done?
      end
    end
  end

  def contract_finder_fetch_links
    ROOT_URL = 'https://www.contractsfinder.service.gov.uk/Search/Results'
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    home = agent.get(ROOT_URL)
    search_form = home.form
    search_form.checkbox_with(name: 'closed').check
    search_form.checkbox_with(name: 'awarded').check
    results = search_form.submit(search_form.button_with(name: 'adv_search'))
    sort_form = results.form_with(name: 'notice_sort')
    sort_field = sort_form.field_with(name: 'sort')
    sort_field.value = sort_field.option_with(text: 'Latest publication date').value
    page = sort_form.submit
    next_page_available = true
    while next_page_available
      next_page_available = false
      links = page.links.select{|l| /Notice/ =~ l.href }.map(&:href)
      links.each do |link|
        a = ScraperLink.find_or_initialize_by link: link, worker_name: 'contract_finder'
        a.pending! unless a.done?
      end
      if next_link = page.links.find{ |l| /Next\d* of \d*/ =~ l.text }
        next_page_available = true
        page = next_link.click
      end
    end
  end

  def ebrd_fetch_links
    (1..61).each do |page|
      link = 'https://www.ebrd.com/cs/Satellite?c=Page&cid=1395238128830&d=&pagename=EBRD/Page/SearchAndFilterProcurement&page='+page.to_s+'&safSortBy=IssueDate&safSortOrder=descending'
      content = get_content(link)
      doc = Nokogiri::HTML(content)
      records = doc.xpath('//*[@id="posts"]/tr')
      records.each do |record| 
        tender_link =  record.xpath('.//td[4]/a/@href').try(:text) || ''
        tender_link = (tender_link[0..2] == '/cs') ? ('https://www.ebrd.com' + tender_link) : ('https:' + tender_link)
        a = ScraperLink.find_or_initialize_by link: tender_link, worker_name: 'ebrd'
        a.pending! unless a.done?
      end
    end
  end

  def buy_and_sell_awards_fetch_links
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


  def buy_and_sell_fetch_links
    main_urls = ["https://buyandsell.gc.ca/procurement-data/search/site?f%5B0%5D=sm_facet_procurement_data%3Adata_data_tender_notice&f%5B1%5D=ss_publishing_status%3ASDS-SS-005",
                "https://buyandsell.gc.ca/procurement-data/search/site?f%5B0%5D=sm_facet_procurement_data%3Adata_data_tender_notice&f%5B1%5D=ss_publishing_status%3ASDS-SS-006"]
    main_urls.each { |main_url| buy_and_sell_fetch_links_from_url(main_url) }
  end

  def buy_and_sell_fetch_links_from_url(startUrl)
    next_page_available = true
    next_page_link = startUrl
    while next_page_available
      content = get_content(next_page_link)
      doc = Nokogiri::HTML(content)
      links = doc.xpath("//ul[@class='search-results']/li").map{ |e| e.xpath('./div/h2/a/@href').text }
      links.each do |link|
        a = ScraperLink.find_or_initialize_by link: link, worker_name: 'buy_and_sell'
        a.pending! unless a.done?
      end
      next_page_link = doc.xpath("//a[@title='Go to next page']/@href").text
      next_page_available = false unless content.include?('Go to next page')
    end
  end

  def fbo_fetch_links
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

  def hostify href, page
    uri = URI.parse href
    unless uri.host
      uri.scheme = page.uri.scheme
      uri.host = page.uri.host
    end
    uri.to_s
  end

  def get_content(url)
    open(url,'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
              "Accept"    => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        "Accept-Language" => 'en-US,en;q=0.5') { |io| io.read }
  end
end
