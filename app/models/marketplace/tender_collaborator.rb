class Marketplace::TenderCollaborator < ApplicationRecord
  belongs_to :collaboration, class_name: 'Marketplace::Collaboration'
  belongs_to :user

  validates :user, uniqueness: true
end
