#define price FactoryBot
FactoryBot.define do
    factory :price_history, class: 'Price' do
      wine
      price { Faker::Commerce.price(range: 10.0..100.0) }
      recorded_at { Faker::Time.backward(days: 365) }
    end
  end