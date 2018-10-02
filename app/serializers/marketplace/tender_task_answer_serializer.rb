class Marketplace::TenderTaskAnswerSerializer < ActiveModel::Serializer
  attributes :id, :pass_fail, :score, :closed
  has_one :user, serializer: UserSerializer
end
