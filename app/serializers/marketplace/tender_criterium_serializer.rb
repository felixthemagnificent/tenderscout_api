class Marketplace::TenderCriteriumSerializer < ActiveModel::Serializer
  attributes :id, :order, :title
  has_many :subcriterias, serializer: Marketplace::TenderCriteriumSerializer
end
