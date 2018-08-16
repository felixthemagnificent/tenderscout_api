class SearchMonitorSerializer < ActiveModel::Serializer
  attributes :id, :title, :tenderTitle, :countryList, :keywordList, :valueFrom, :valueTo, :codeList, :buyerList, :statusList
end
