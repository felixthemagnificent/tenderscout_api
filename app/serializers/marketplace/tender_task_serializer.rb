class Marketplace::TenderTaskSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :weight, :description, :deadline
  has_many :answers
end
