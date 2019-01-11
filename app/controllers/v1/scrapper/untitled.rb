
  def tender_bulk_upload
    index = 0
    tenders = Origin::Web::Tender.where('id > ?', 8410436)
    tenders.each do |e|
      index += 1
      puts '*'*20
      puts "#{index}/#{tenders.count}"
      tender_send(e)
    end
  end

  def tender_send(tender)
    tender_hash = tender.attributes
    tender_hash.merge!({name: tender.try(:organization).try(:name), country_name: tender.try(:country).try(:name)})
    tender_hash['tender_urls'] = tender_hash['tender_urls'].first
    tender_hash['origin_id'] = tender_hash['spider_id'].to_s
    uri = URI('https://hub.tenderscout.com/api/v1/scrapper/input')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    req = Net::HTTP::Post.new(uri.path)
    req.add_field('Content-Type', 'application/json')
    req.body = tender_hash.to_json
    res = http.request(req)
    puts "response #{res.body}"
  rescue => e
    puts "failed #{e}"
  end
