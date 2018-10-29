class Marketplace::TenderQualificationCriteriaAnswerSerializer < ActiveModel::Serializer
  attributes :id, :pass_fail, :score, :closed, :created_at
  has_one :user, serializer: UserSerializer
end
