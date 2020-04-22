class Anniversary < ApplicationRecord
  	belongs_to :portrait
  	belongs_to :user
  	validates :title, presence: true, length: {minimum: 2, maximum: 30}
  	validates :memo, length: {maximum: 200}

  	def one_anniversary? #通知用の一周忌の前日を定義
    	Date.yesterday <= date.since(1.years) && date.since(1.years) < Date.today
  	end
end
