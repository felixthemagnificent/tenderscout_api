module Assignable
  extend ActiveSupport::Concern

  included do
    def profile
      section = self.section
      return nil unless user_id.present?
      collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: section.tender.id), user: user_id).first.collaboration
      self.assignments.where(collaboration: collaboration).first.user.profiles.first rescue nil
    end

    def assignment
      section = self.section
      return nil unless user_id.present?
      collaboration = Marketplace::TenderCollaborator.where(collaboration: Marketplace::Collaboration.where(tender: section.tender.id).ids, user: user_id).first.collaboration
      self.assignments.where(collaboration: collaboration).first rescue nil
    end
  end
end