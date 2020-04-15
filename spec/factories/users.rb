FactoryBot.define do
  factory :user do
    name { 'TEST' }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    introduction {'hallo'}
  end
end