FactoryBot.define do
  factory :invoice do
    association :customer, factory: :customer
    association :merchant, factory: :merchant
    status { ["shipped", "packaged", "returned", "pending", "cancelled"].sample }
    created_at { Faker::Date.between(from: 5.years.ago, to: Date.today) }
    updated_at {  Faker::Date.between(from: 5.years.ago, to: Date.today) }
  end
end
