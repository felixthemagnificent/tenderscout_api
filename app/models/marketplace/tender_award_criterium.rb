class Marketplace::TenderAwardCriterium < ApplicationRecord
  belongs_to :tender_award_criteria_section, class_name: 'Marketplace::TenderAwardCriteriaSection', foreign_key: :section_id
end
