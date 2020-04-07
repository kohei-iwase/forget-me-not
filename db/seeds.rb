# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


#検証用ユーザー
User.create!(name: "ジョン・ウィック",
			email: "1@1",
			password: "111111", password_confirmation: "111111")

Portrait.create!(user_id:1,
				image: File.open("./app/assets/images/beagle1.jpg"),
				name: "デイジー",
				gender:1,
				age:10,
			    species:"ビーグル",
    			date_of_birth:"2010年１月３日",
    			anniversary:"2020年３月９日",
    			likes_and_dislikes:"チュールが大好物でした",
			    interest:"晴れた日のお散歩、ボール遊び",
    			specialty:"お行儀がとても良かったです",
		    	family:"子供が二人います。",
    			personality:"甘えん坊でおっちょこちょい",
    			found:"単身赴任がおおっ飼った時に、妻が誕生日に贈ってくれました",
				more_about_me:  "亡き妻の最期の贈り物でした、私に安らぎを与えてくれました")
Memory.create!(portrait_id: 1,
    			title:"初めてのお散歩",
    			when:"最初にうちに来た時",
    			memory:"初めて見るものがいっぱいでキラキラさせていたのをよく覚えています",
    			image: File.open("./app/assets/images/beagle2.jpg")
    			)
Memory.create!(portrait_id: 1,
    			title:"少し眠そう",
    			when:"８年前",
    			memory:"でも、カメラを向けるとキメ顔してくれてたね",
    			image: File.open("./app/assets/images/beagle3.jpg")
    			)
Memory.create!(portrait_id: 1,
    			title:"大好き",
    			when:"毎日",
    			memory:"今でもどこかにいるような気がする",
    			image: File.open("./app/assets/images/beagle4.jpg")
    			)


#ユーザーを50人作成
30.times do
name = Faker::Name.name
email = Faker::Internet.email
password = "password"
User.create!(name: name,
			email: email,
			password: password,
			password_confirmation: password)
end

#最初の20名のユーザーにポートレートを作成(ポケモンの名前を使用)
users = User.order(:created_at).take(20)
3.times do
name = Faker::Creature::Cat.name
more_about_me = Faker::Creature::Cat.registry
users.each { |user| user.portraits.create!(name: name,more_about_me: more_about_me) } 
end

#ポートレートにメモリーを作成
portraits = Portrait.order(:created_at).take(20)
5.times do
title = Faker::Creature::Dog.sound
memory = Faker::Quotes::Shakespeare.hamlet_quote
portraits.each { |portrait| portrait.memories.create!(title: title,memory: memory) } 
end