class Users::UpgradeRequestSerializer < ActiveModel::Serializer
  has_one :user, serializer: UserSerializer
  attributes  :created_at, :upgraded_at
end
