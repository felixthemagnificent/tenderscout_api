module Assignable
  extend ActiveSupport::Concern

  included do
    def profile
      section = self.section
      collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: section.tender.id), user: user_id).first.collaboration
      self.assignments.where(collaboration: collaboration).first.user.profiles.first
    end

    def assignment
      section = self.section
      collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: section.tender.id).ids, user: user_id).first.collaboration
      self.assignments.where(collaboration: collaboration).first
    end
  end
end