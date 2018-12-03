class SearchMonitor < ApplicationRecord
  mount_uploader :export, MonitorExportUploader
  belongs_to :user
  
  def downloadable_export_url
    self.export.url(query: {"response-content-disposition" => "attachment;"})
  end

  def results(sort_by, sort_direction)
    Core::Tender.search(
        tender_title: tenderTitle,
        tender_keywords: keywordList,
        tender_value_from: valueFrom,
        tender_value_to: valueTo,
        tender_countries: countryList,
        tender_buyers: buyer,
        tender_statuses: status,
        tender_sort: {
          sort_by: sort_by,
          sort_direction: sort_direction
        }
    )
  end


end
