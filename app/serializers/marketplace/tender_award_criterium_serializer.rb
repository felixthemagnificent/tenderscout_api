class Marketplace::TenderAwardCriteriumSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :description, :weight, :deadline, :profile, :files
  has_many :answers, serializer: Marketplace::TenderAwardCriteriumAnswerSerializer
end
