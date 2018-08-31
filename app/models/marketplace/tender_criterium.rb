class Marketplace::TenderCriterium < ApplicationRecord
  belongs_to :section, class_name: 'Marketplace::TenderCriteriaSection', foreign_key: :section_id
end
