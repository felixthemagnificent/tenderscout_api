class Profile < ApplicationRecord
  has_many :contacts
  belongs_to :user
  validates_presence_of :fullname, :display_name, :company, :timezone, :user_id
end
