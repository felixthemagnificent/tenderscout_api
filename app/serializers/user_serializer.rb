class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role, :flags
  attribute(:do_marketplace_available) { object.available? }
  attribute(:profile_type) { object.profiles.try(:first).try(:profile_type) }
  has_many :profiles, serializer: ProfileSerializer
end
