class Marketplace::TenderAwardCriteriaAnswer < ApplicationRecord
  belongs_to :award_criteria, class_name: 'Marketplace::TenderAwardCriterium', foreign_key: :tender_award_criteria_id
  belongs_to :user
end
