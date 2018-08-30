class Core::Sfgov < ApplicationRecord
  self.table_name = "core_sfgov_codes"
  has_many :tender_sfgovs
  has_many :tenders, through: :tender_sfgovs

  # def format_fields
  #   {
  #     ngip_codes: [code]
  #   }
  # end
end
