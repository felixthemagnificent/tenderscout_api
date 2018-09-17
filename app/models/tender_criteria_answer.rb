class TenderCriteriaAnswer < ApplicationRecord
  belongs_to :criteria, class_name: 'Marketplace::TenderCriterium', foreign_key: :tender_criteria_id
  belongs_to :user
end
