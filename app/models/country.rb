class Country < ApplicationRecord
  belongs_to :currency
  belongs_to :world_region
end
