FactoryBot.define do
  factory :comment do
    comment { Faker::Lorem.characters(number:140)}
  end
end