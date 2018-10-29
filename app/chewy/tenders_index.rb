class TendersIndex < Chewy::Index

  define_type Core::Tender.where('id > ?', (Core::Tender.last.id - 1000)) do
    field :title, value: -> (tender) { tender.title }
    field :description, value: -> (tender) { (tender.description.gsub(/[^0-9A-Za-z \t]/i, '').gsub(/\t/,' ') rescue '') }
    field :created_at, type: 'date', value: ->{ created_at } 
    field :country_id, value: ->(tender) { tender.try(:country).try(:id) }
    field :low_value, value: ->(tender) { tender.estimated_low_value.to_i }, type: :integer
    field :high_value, value: ->(tender) { tender.estimated_high_value.to_i }, type: :integer
    field :ic_nuts_codes, value: -> (tender) {tender.nuts_codes}
    field :ic_cpvs, value: ->(tender) { tender.try(:cpvs).try(:ids) }
    field :ic_naicses, value: -> (tender) { tender.try(:naicses).try(:ids) }
    field :ic_ngips, value: -> (tender) { tender.try(:ngips).try(:ids) }
    field :ic_unspsces, value: -> (tender) { tender.try(:unspsces).try(:ids) }
    field :ic_gsins, value: -> (tender) { tender.try(:gsins).try(:ids) }
    field :ic_nhs_e_classes, value: -> (tender) { tender.try(:nhs_e_classes).try(:ids) }
    field :ic_pro_classes, value: -> (tender) { tender.try(:pro_classes).try(:ids) }
  end
end