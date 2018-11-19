class Assistance < ApplicationRecord
  include Pageable
  belongs_to :user

  enum assistance_type: [:tender, :bid, :other]
  enum status: [:opened, :closed]

  validates_presence_of :assistance_type, :status
end
