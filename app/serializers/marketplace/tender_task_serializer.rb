class Marketplace::TenderTaskSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :weight, :description, :parent_id
  has_many :answers
end
