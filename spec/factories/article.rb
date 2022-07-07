FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number:50) }
    body { Faker::Lorem.characters(number:2000) }
    user
  end
end
