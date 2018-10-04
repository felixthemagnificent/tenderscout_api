class CommentSerializer < ActiveModel::Serializer
  belongs_to :profile, serializer: ProfileSerializer
  attributes :id, :profile_id, :body, :created_at, :updated_at, :parent_id
end