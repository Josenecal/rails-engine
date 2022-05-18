FactoryBot.define do
  factory :transaction do
    credit_card_number: { Faker::CreditCard.number }
    credit_card_expiration_date: { Faker::Date.forward(days: 3650)}
    result: { ["success", "failed"].sample }
    created_at: { Faker::Date.between(from: 5.years.ago, to: Date.today) }
    updated_at: {  Faker::Date.between(from: 5.years.ago, to: Date.today) }
    association :invoice, factory: :invoice
  end
end
