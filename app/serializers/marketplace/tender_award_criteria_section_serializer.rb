class Marketplace::TenderAwardCriteriaSectionSerializer < ActiveModel::Serializer
  attributes :id, :order, :title
  has_many :award_criteries, serializer: Marketplace::TenderAwardCriteriumSerializer
end
