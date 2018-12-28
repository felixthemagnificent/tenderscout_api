class Core::AwardsSerializer < ActiveModel::Serializer
  attributes :lot_title, :lot_number, :awarded_on, :contract_number, :offers_count, :value
end
