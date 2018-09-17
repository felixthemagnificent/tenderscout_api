class CollaborationInterest < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  belongs_to :user
end
