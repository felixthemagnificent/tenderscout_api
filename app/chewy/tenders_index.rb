class TendersIndex < Chewy::Index

  define_type Core::Tender.where('id > ?', (Core::Tender.last.id - 1000)) do
    field :title, value: -> (tender) { tender.title }
    field :description, value: -> (tender) { tender.description.gsub(/[^0-9A-Za-z \t]/i, '').gsub(/\t/,' ') }
    field :created_at
  end
end