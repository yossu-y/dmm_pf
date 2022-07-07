FactoryBot.define do
  factory :user do
    screen_name { Faker::Lorem.characters(number:30) }
    introduction { Faker::Lorem.characters(number:350) }
    email { Faker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end
end
