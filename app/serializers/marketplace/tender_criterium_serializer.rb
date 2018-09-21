class Marketplace::TenderCriteriumSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :description, :parent_id
#  has_many :subcriterias, serializer: Marketplace::TenderCriteriumSerializer
end
