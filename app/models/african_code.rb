class AfricanCode < ApplicationRecord
  include ActiveModel::Serialization

  def code_name
    'african'
  end
end
