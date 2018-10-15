class Marketplace::TenderQualificationCriteriaSectionSerializer < ActiveModel::Serializer
  attributes :id, :order, :title
  has_many :qualification_criterias, serializer: TenderQualificationCriteriaSerializer
end
