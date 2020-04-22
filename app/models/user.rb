class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  #ログイン
  devise 	:database_authenticatable, :registerable,
         	:recoverable, :rememberable, :validatable

  #写真アップロード用
  attachment :image

  #アルバム用
  has_many 	:portraits, dependent: :destroy

  #アルバム用献花
  has_many	:bouquets, dependent: :destroy

  #命日用
  has_many  :anniversaries, dependent: :destroy

  #思い出用献花
  has_many	:flowers,	dependent: :destroy

  #フォロイー表示
  has_many 	:active_relationships, class_name: "Relationship",
  									foreign_key: "follower_id",
  									dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'user_id', dependent: :destroy

  #フォロワー表示
  has_many 	:passive_relationships, class_name: "Relationship",
  									foreign_key: "followed_id",
  									dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'user_id', dependent: :destroy



  #バリデーション
  validates :email, length: {minimum: 3, maximum: 80}
  validates :name, length: {minimum: 2, maximum: 30}
  validates :introduction, length: {maximum: 200}

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

	# ユーザーのタイムラインを返す 
	def timeline
		following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
		Portrait.where("user_id IN (#{following_ids})
                    OR user_id = :user_id", user_id: id)
	end

end
