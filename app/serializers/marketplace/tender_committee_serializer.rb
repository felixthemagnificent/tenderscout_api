class Marketplace::TenderCommitteeSerializer < ActiveModel::Serializer
  attributes :id
  has_one :tender
  has_one :user
end
