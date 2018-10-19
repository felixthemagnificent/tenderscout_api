class Marketplace::TenderCollaborator < ApplicationRecord
  belongs_to :collaboration, class_name: 'Marketplace::Collaboration'
  belongs_to :user
  enum role: [:owner, :admin, :editor, :viewer]

  validates :role, presence: true
  validates :user, uniqueness: { scope: [:collaboration_id] }
end
