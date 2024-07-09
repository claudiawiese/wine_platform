#define review FactoryBot
FactoryBot.define do
    factory :review do
        wine
        user
        sequence(:id)
        rating { Faker::Number.between(from: 0, to: 5) }
        comment { Faker::Lorem.sentence }
    end
  end

