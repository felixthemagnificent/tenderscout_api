class SearchMonitor < ApplicationRecord
  belongs_to :user

  def self.process_search(search_monitor_params)
      tender_title = search_monitor_params[:tenderTitle]
      tender_keywords = search_monitor_params[:keywordList]
      tender_value_from = search_monitor_params[:valueFrom]
      tender_value_to = search_monitor_params[:valueTo]
      tender_countries = search_monitor_params[:countryList]
      tender_buyers = search_monitor_params[:buyer]
      results = Core::Tender.search(
          tender_title: tender_title,
          tender_keywords: tender_keywords,
          tender_value_from: tender_value_from,
          tender_value_to: tender_value_to,
          tender_countries: tender_countries,
          tender_buyers: tender_buyers
      )
      return results
  end


end
