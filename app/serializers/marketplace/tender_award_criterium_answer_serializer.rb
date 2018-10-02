class Marketplace::TenderAwardCriteriaAnswerSerializer < ActiveModel::Serializer
  # attributes :id, :order, :title
  # has_many :award_criteries, serializer: Marketplace::TenderAwardCriteriumSerializer
  attributes :id, :pass_fail, :score, :closed
  has_one :user, serializer: UserSerializer
end
