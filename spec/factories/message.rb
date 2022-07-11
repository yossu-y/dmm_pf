FactoryBot.define do
  factory :message do
    message { Faker::Lorem.characters(number:500)}
  end
end
