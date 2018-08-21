class RegistrationRequest < ApplicationRecord
  belongs_to :country
  belongs_to :industry
end
