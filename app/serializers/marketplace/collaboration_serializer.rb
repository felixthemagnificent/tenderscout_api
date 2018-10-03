class Marketplace::CollaborationSerializer < ActiveModel::Serializer
  attributes :id
  has_one :tender
end
