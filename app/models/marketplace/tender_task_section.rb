class Marketplace::TenderTaskSection < ApplicationRecord
  belongs_to :tender, class_name: 'Core::Tender'
  has_many :tasks, class_name: 'Marketplace::TenderTask', foreign_key: :section_id, dependent: :destroy
end
