class Memory < ApplicationRecord
	belongs_to :portrait
	belongs_to :user

	attachment :image
end
