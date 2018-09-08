class Marketplace::TenderCriterium < ApplicationRecord
  belongs_to :section, class_name: 'Marketplace::TenderCriteriaSection', foreign_key: :section_id
  has_many :subcriterias, class_name: 'Marketplace::TenderCriterium', foreign_key: :parent_id
  belongs_to :parent, class_name: 'Marketplace::TenderCriterium'
end
