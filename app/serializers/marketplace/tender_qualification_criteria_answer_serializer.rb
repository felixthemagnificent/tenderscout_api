class Marketplace::TenderQualificationCriteriaAnswerSerializer < ActiveModel::Serializer
  attributes :id, :pass_fail, :score, :closed, :created_at, :updated_at, :collaboration_id
  has_one :user, serializer: UserSerializer
end
