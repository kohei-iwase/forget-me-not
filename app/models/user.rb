class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise 	:database_authenticatable, :registerable,
         	:recoverable, :rememberable, :validatable
  has_many 	:portraits, dependent: :destroy
  has_many	:bouquets, dependent: :destroy
  has_many	:flowers,	dependent: :destroy
  has_many 	:active_relationships, class_name: "Relationship",
  									foreign_key: "follower_id",
  									dependent: :destroy
  has_many 	:passive_relationships, class_name: "Relationship",
  									foreign_key: "followed_id",
  									dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'user_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'user_id', dependent: :destroy
  attachment :image


	# ユーザーをフォローする 
	def follow(other_user)
		active_relationships.create(followed_id: other_user.id) 
	end

	# ユーザーをフォロー解除する 
	def unfollow(other_user)
		active_relationships.find_by(followed_id: other_user.id).destroy 
	end
	# 現在のユーザーがフォローしてたら true を返す 
	def following?(other_user)
		following.include?(other_user) 
	end

	# ユーザーのステータスフィードを返す 
	def feed
		following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
		Portrait.where("user_id IN (#{following_ids})OR user_id = :user_id", user_id: id)
	end

end
