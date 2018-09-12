class Marketplace::TenderTask < ApplicationRecord
  belongs_to :section, class_name: 'Marketplace::TenderTaskSection', foreign_key: :section_id
  has_many :answers, class_name: 'TenderTaskAnswer', foreign_key: :tender_task_id
end
