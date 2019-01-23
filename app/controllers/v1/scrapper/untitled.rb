
  def tender_bulk_upload
    index = 0
    records = []
    tenders = Tender.all #.desc('created_at').limit(1).to_a
    tenders.each do |e|
      index += 1
      puts '*'*20
      puts "#{index}/#{tenders.count}"
      records << tender_prepare(e)
      if records.count > 1000
        tender_send records
        records.clear
      end
    end
    return nil
  end

  def tender_prepare(tender)
    tender_hash = tender.attributes
    tender_hash.merge!({name: tender.try(:organization).try(:name), country_name: tender.try(:country).try(:name)})
    tender_hash['tender_urls'] = ['tender_urls'][0]['url']
    tender_hash
  end

  def tender_send(tenders)
    tender_hash = {required: tenders}
    # tender_hash['origin_id'] = tender_hash['spider_id'].to_s
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

tender_bulk_upload