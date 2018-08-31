class Marketplace::TenderTaskSectionSerializer < ActiveModel::Serializer
  attributes :id, :order, :title
  has_many :tasks, serializer: TenderTaskSerializer
end
