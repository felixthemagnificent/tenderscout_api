class Assistance < ApplicationRecord
  belongs_to :user

  enum assistance_type: [:tender, :bid, :other]
  enum status: [:opened, :closed]
end
