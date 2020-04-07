class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise 	:database_authenticatable, :registerable,
         	:recoverable, :rememberable, :validatable
  has_many 	:portraits, dependent: :destroy
  has_many	:bouquets, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'user_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'user_id', dependent: :destroy
  attachment :profile_image
end
