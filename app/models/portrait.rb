class Portrait < ApplicationRecord
	belongs_to 	:user
	has_many	:memories, dependent: :destroy
	attachment 	:image
end
