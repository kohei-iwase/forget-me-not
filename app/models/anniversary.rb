class Anniversary < ApplicationRecord
  	belongs_to :portrait
  	validates :title, presence: true, length: {minimum: 2, maximum: 30}
  	validates :memo, length: {maximum: 200}



  	def one_anniversary?
    	Date.yesterday <= date.since(1.years) && date.since(1.years) < Date.today
  	end
end
