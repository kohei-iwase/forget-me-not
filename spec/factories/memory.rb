FactoryBot.define do
  factory :memory do
    title { Faker::Lorem.characters(number:5) }
    memory { Faker::Lorem.characters(number:50) }
  end
end