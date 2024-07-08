#define review FactoryBot
FactoryBot.define do
    factory :review do
        sequence(:id)
        rating { Faker::Number.between(from: 0, to: 5) }
        comment { Faker::Lorem.sentence }
        association :user
        association :wine
    end
  end

