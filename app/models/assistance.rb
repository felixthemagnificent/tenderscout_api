class Assistance < ApplicationRecord
  include Pageable
  belongs_to :user
  belongs_to :tender, class_name: 'Core::Tender'

  enum assistance_type: [:tender, :bid, :other]
  enum status: [:opened, :closed]

  validates_presence_of :assistance_type, :status
end
