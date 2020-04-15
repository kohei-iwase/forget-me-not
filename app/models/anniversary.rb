class Anniversary < ApplicationRecord
  	belongs_to :portrait


  	def one_anniversary?
    	Date.yesterday <= date.since(1.years) && date.since(1.years) < Date.today
  	end
end
