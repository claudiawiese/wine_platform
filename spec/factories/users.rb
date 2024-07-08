FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
      password { Faker::Internet.password }
    end
    factory :devise_api_token, class: 'Devise::Api::Token' do
      association :resource_owner, factory: :user
      access_token { SecureRandom.hex(32) }
      refresh_token { SecureRandom.hex(32) }
      expires_in { 3.hour.to_i }
    end
  end