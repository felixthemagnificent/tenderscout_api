class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role
  attribute(:profile_type) { object.profiles.first.profile_type }
  has_many :profiles, serializer: ProfileSerializer
end
