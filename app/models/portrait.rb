class Portrait < ApplicationRecord
	belongs_to 	:user
	has_many	:memories, dependent: :destroy
	has_many	:bouquets, dependent: :destroy
	attachment 	:image

	validates :name, presence: true

	def bouquet_by?(user)
          bouquets.where(user_id: user.id).exists?
    end
end
