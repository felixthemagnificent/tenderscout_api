class TendersIndex < Chewy::Index

  define_type Core::Tender.where('id > ?', (Core::Tender.last.id - 1000)) do
    field :title, value: -> (tender) { tender.title }
    field :description, value: -> (tender) { tender.description.gsub(/[^0-9A-Za-z \t]/i, '').gsub(/\t/,' ') }
    field :created_at, type: 'date', value: ->{ created_at } 
    field :country_id, value: ->(tender) { tender.try(:country).try(:id) }
    field :low_value, value: ->(tender) { tender.estimated_low_value.to_i }, type: :integer
    field :high_value, value: ->(tender) { tender.estimated_high_value.to_i }, type: :integer
  end
end