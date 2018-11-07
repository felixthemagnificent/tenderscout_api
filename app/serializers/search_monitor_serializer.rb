class SearchMonitorSerializer < ActiveModel::Serializer
  attributes :id, :title, :tenderTitle, :countryList, :keywordList, :valueFrom, :valueTo, :codeList, :buyer, :statusList, :is_archived
  attribute(:is_favourite) { is_favourite_monitor?(object)}

  def is_favourite_monitor?(monitor)
    current_user.favourite_monitors.where(search_monitor: monitor).any?
  end
end
