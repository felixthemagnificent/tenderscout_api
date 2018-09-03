FactoryBot.define do
  factory :country, class: Core::Country do

    currency
    code { '376' }
    number { '020' }
    alpha2code { 'AD' }
    alpha3code { 'AND' }
    name { 'Andorra' }
    #world_region
    world_region { 'Europe' }

    world_subregion { 'Southern Europe' }

    # currency_id { 1 }
    #world_region_id { 1 }
  end

end