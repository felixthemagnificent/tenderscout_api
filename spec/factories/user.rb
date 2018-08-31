# factories for user
FactoryBot.define do
  factory :user do
    email         { Faker::Internet.email }
    password      { Faker::Internet.password }
    role          { 1 }
    fullname      { Faker::Name.name }
    confirmed_at  { '2016-07-17 07:35:55.139051' }
  end


end