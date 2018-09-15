class Marketplace::TenderCriteriumSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :description
  has_many :subcriterias, serializer: Marketplace::TenderCriteriumSerializer
end
