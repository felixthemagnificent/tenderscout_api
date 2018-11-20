class Marketplace::BidResult < ApplicationRecord
  belongs_to :collaboration, class_name: 'Marketplace::Collaboration', foreign_key: :collaboration_id
end