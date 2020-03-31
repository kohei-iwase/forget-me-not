class Memory < ApplicationRecord
	belongs_to :portrait
	attachment :image
end
