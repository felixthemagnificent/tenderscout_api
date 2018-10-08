class Marketplace::TenderTaskAnswer < ApplicationRecord
  belongs_to :task, class_name: 'Marketplace::TenderTask', foreign_key: :tender_task_id
  belongs_to :user
end
