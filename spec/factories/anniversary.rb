FactoryBot.define do
  factory :anniversary do
  	date {20200302}
    title { Faker::Lorem.characters(number:5) }
    memo { Faker::Lorem.characters(number:50) }
  end
end

