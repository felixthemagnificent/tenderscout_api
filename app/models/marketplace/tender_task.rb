class Marketplace::TenderTask < ApplicationRecord
  belongs_to :section, class_name: 'Marketplace::TenderTaskSection', foreign_key: :section_id
  has_many :answers, class_name: 'Marketplace::TenderTaskAnswer', foreign_key: :tender_task_id, dependent: :destroy
  has_many :comments, as: :commentable
  has_many :notes, as: :notable
  has_many :assignments, class_name: 'Marketplace::Assignment', as: :assignable
  attr_accessor :user_id

  def profile
    tender = Core::Tender.find_by(id: tender_id)
    collaboration = Marketplace::TenderCollaborator.where(collaboration: Collaboration.where(tender: tender).ids, user: user_id).first.collaboration
    self.assignments.where(collaboration: collaboration).first.user.profiles.first
  end
end
