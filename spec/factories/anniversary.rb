FactoryBot.define do
  factory :anniversary do
    date { 20_200_302 }
    title { Faker::Lorem.characters(number: 5) }
    memo { Faker::Lorem.characters(number: 50) }
  end
end
