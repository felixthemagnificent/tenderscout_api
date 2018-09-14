class Marketplace::TenderAwardCriteriaSectionSerializer < ActiveModel::Serializer
  attributes :id, :order, :title
  has_one :tender
end
