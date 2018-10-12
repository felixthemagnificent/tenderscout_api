class Marketplace::TenderQualificationCriteriaAnswer < ApplicationRecord
  belongs_to :qualification_criteria, class_name: 'Marketplace::TenderQualificationCriteria', foreign_key: :tender_qualification_criteria_id
  belongs_to :user
end
