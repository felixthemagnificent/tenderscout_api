class Marketplace::TenderCommittee < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  belongs_to :user

  validates :user, uniqueness: true
end
