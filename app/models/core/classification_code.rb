class Core::ClassificationCode < ApplicationRecord
  self.table_name = "core_classification_codes"

  def format_fields
    {
      classification_code: code,
      classification_description: description
    }
  end
end
