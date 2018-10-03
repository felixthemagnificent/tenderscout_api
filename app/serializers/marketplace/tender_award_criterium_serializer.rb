class Marketplace::TenderAwardCriteriumSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :description, :weight
  has_many :answers, serializer: Marketplace::TenderAwardCriteriumAnswerSerializer
end
