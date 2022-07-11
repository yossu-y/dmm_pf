FactoryBot.define do
  factory :admin do
    email { Faker::INternet.email }
    password { "password" }
    password_confirmation { "password" }
  end
end
