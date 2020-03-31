class Portrait < ApplicationRecord
	belongs_to :user
	attachment :image
end
