class IndustryCodesIndex < Chewy::Index

  define_type IndustryCode.where('id > ?', (IndustryCode.last.id - 1000)) do
    field :title, value: -> (tender) { tender.title }
    field :description, value: -> (tender) { tender.description.gsub(/[^0-9A-Za-z \t]/i, '').gsub(/\t/,' ') }
    field :created_at, type: 'date', value: ->{ created_at } 
    field :country_id, value: ->(tender) { tender.try(:country).try(:id) }
  end
end