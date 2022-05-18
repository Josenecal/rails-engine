FactoryBot.describe do
  factory :invoice_item do
    association :invoice, factory: :invoice
    association :item, factory: :item
    quantity: { rand 0..100 }
    unit_price: { rand(0..1000) }
    created_at: { Faker::Date.between(from: 5.years.ago, to: Date.today) }
    updated_at: {  Faker::Date.between(from: 5.years.ago, to: Date.today) }
  end
end
