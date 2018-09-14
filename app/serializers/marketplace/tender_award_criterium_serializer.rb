class Marketplace::TenderAwardCriteriumSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :description
  has_one :tender_award_criteria_section
end
