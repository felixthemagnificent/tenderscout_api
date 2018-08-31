class Marketplace::TenderTask < ApplicationRecord
  belongs_to :section, class_name: 'Marketplace::TenderTaskSection', foreign_key: :section_id
end
