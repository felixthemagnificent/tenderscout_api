class Marketplace::TenderTaskSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :weight, :description
  has_many :answers
end
