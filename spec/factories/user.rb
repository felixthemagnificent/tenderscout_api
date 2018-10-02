# factories for user
FactoryBot.define do
  factory :user do
    email         { Faker::Internet.email }
    password      { Faker::Internet.password }
    role          { 1 }
    confirmed_at  { DateTime.now }
  end

  factory :admin do
    email         { Faker::Internet.email }
    password      { Faker::Internet.password }
    role          { 0 }
    confirmed_at  { DateTime.now }
  end

end