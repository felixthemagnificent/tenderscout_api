class Marketplace::CollaborationSerializer < ActiveModel::Serializer
  attributes :id
  has_many :users, through: :tender_collaborators
  # has_one :tender
end
