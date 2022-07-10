FactoryBot.define do
  factory :group do
    name { Faker::Lorem.characters(number:50) }
    introduction { Faker::Lorem.characters(number:800) }
  end
end