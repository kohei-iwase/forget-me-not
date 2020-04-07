class Memory < ApplicationRecord
	belongs_to  :portrait
	has_many	:bouquet, dependent: :destroy
	has_many :notifications, dependent: :destroy
	attachment  :image
end
