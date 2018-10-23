class UserSerializer < ActiveModel::Serializer
  attributes :id, :email
  attribute :collaboration_role
  has_many :profiles, serializer: ProfileSerializer
end
