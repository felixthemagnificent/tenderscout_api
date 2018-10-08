class Marketplace::TenderAwardCriterium < ApplicationRecord
  belongs_to :tender_award_criteria_section, class_name: 'Marketplace::TenderAwardCriteriaSection', foreign_key: :section_id
  has_many :answers, class_name: 'Marketplace::TenderAwardCriteriaAnswer', foreign_key: :tender_award_criteria_id
  has_many :comments, as: :commentable
  has_many :notes, as: :notable
end
