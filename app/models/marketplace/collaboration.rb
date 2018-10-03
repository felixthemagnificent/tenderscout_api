class Marketplace::Collaboration < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  has_many :tender_collaborators, class_name: 'Marketplace::TenderCollaborator'
  has_many :users, through: :tender_collaborators
end
