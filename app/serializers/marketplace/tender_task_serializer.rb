class Marketplace::TenderTaskSerializer < ActiveModel::Serializer
  attributes :id, :order, :title, :weight, :description, :deadline, :tender_id, :profile
  has_many :answers
end
