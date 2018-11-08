class SearchMonitor < ApplicationRecord
  belongs_to :user
  
  def results
    Core::Tender.search(
        tender_title: tenderTitle,
        tender_keywords: keywordList,
        tender_value_from: valueFrom,
        tender_value_to: valueTo,
        tender_countries: countryList,
        tender_buyers: buyer
    )
  end


end
