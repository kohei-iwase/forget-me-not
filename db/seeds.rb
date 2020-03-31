# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#検証用ユーザー
User.create!(name: "Example User",
email: "1@1",
password: "111111", password_confirmation: "111111")

#ユーザーを50人作成
49.times do
name = Faker::Name.name
email = Faker::Internet.email
password = "password"
User.create!(name: name,
			email: email,
			password: password,
			password_confirmation: password)
end

#ペットのポートフォリオを作成(ポケモンの名前を使用)
users = User.order(:created_at).take(20)
3.times do
name = Faker::Creature::Cat.name
more_about_me = Faker::Creature::Cat.registry
users.each { |user| user.portraits.create!(name: name,more_about_me: more_about_me) } 
end

#メモリーを作成
portraits = Portrait.order(:created_at).take(20)
5.times do
title = Faker::Creature::Dog.sound
memory = Faker::Quotes::Shakespeare.hamlet_quote
portraits.each { |portrait| portrait.memories.create!(title: title,memory: memory) } 
end