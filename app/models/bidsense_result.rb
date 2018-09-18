class BidsenseResult < ApplicationRecord
  belongs_to :profile
  belongs_to :tender

 def calculate
  calculate_fields = [self.budget, self.geography, self.subject, self.incumbent, self.time, self.buyer_related]
  result = calculate_fields.sum/calculate_fields.count
 end

end
