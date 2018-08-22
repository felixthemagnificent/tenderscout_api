class Profile < ApplicationRecord
  has_many :contacts
  belongs_to :user
  belongs_to :country, class_name: 'Core::Country'
  belongs_to :industry

  enum profle_type: [:consultant, :company]

  validates_presence_of :fullname, :display_name, :timezone, :profile_type, :user_id
  validates_presence_of :company_size, :turnover unless :profile_type != :consultant
end
