class Memory < ApplicationRecord
	belongs_to  :portrait
	has_many	:flowers
	attachment  :image

	def flower_by?(user)
          flowers.where(user_id: user.id).exists?
    end
end
