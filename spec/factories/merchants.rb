FactoryBot.define do
  factory :merchant do
    name { Faker::Commerce.vendor }
    created_at { Faker::Date.between(from: 5.years.ago, to: Date.today) }
    updated_at {  Faker::Date.between(from: 5.years.ago, to: Date.today) }
  end
end
