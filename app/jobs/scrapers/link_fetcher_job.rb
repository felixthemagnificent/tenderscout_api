class Scrapers::LinkFetcherJob < ApplicationJob
  queue_as :scrapers

  def perform
    fbo_fetch_links
    buy_and_sell_fetch_links
    buy_and_sell_awards_fetch_links
    Scrapers::LinkFetcherJob.perform_later
  end

  private

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

  def get_content(url)
    open(url,'User-Agent' => 'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.110 Safari/537.36',
              "Accept"    => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
        "Accept-Language" => 'en-US,en;q=0.5') { |io| io.read }
  end
end
