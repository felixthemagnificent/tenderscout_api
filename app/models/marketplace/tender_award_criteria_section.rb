class Marketplace::TenderAwardCriteriaSection < ApplicationRecord
  belongs_to :tender
  has_many :award_criteries, class_name: 'Marketplace::TenderAwardCriterium', foreign_key: :section_id
end
