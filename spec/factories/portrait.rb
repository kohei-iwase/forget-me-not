FactoryBot.define do
  factory :portrait do
    name { Faker::Lorem.characters(number: 5) }
    species { 'ねこ' }
    more_about_me { Faker::Lorem.characters(number: 200) }
  end
end
