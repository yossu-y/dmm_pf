FactoryBot.define do
  factory :contact do
    name { Faker::Lorem.characters(number:10) }
    email { Faker::Internet.email }
    message { Faker::Lorem.characters(number:500) }
  end
end
