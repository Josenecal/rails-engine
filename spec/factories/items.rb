FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.paragraph(sentence_count: 2)}
    unit_price { rand(1..1000) }
    association :merchant, factory: :merchant
    created_at { Faker::Date.between(from: 5.years.ago, to: Date.today) }
    updated_at {  Faker::Date.between(from: 5.years.ago, to: Date.today) }
  end
end
