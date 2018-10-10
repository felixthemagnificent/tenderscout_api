class Marketplace::TenderAwardCriterium < ApplicationRecord
  belongs_to :tender_award_criteria_section, class_name: 'Marketplace::TenderAwardCriteriaSection', foreign_key: :section_id
  has_many :answers, class_name: 'Marketplace::TenderAwardCriteriaAnswer', foreign_key: :tender_award_criteria_id
  has_many :comments, as: :commentable
  has_many :notes, as: :notable
  has_many :assignments, class_name: 'Marketplace::Assignment', as: :assignable
  attr_accessor :user_id

  def profile
    section = Marketplace::TenderAwardCriteriaSection.find_by(id: section_id)
    collaboration = Marketplace::TenderCollaborator.where(collaboration: Collaboration.where(tender: section.tender.id), user: user_id).first.collaboration
    self.assignments.where(collaboration: collaboration).first.user.profiles.first
  end
end
