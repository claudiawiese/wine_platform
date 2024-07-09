#define wine FactoryBot
FactoryBot.define do
    factory :wine do
        sequence(:id)
        name { Faker::Lorem.word }
        variety { Faker::Lorem.word }
        region { Faker::Address.city }
        year { Faker::Number.between(from: 1900, to: Date.today.year) }
    end
  end
