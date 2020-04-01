class Memory < ApplicationRecord
	belongs_to  :portrait
	has_many	:bouquet
	attachment  :image
end
