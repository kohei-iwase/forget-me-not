class Memory < ApplicationRecord
  belongs_to :portrait
  has_many   :flowers
  has_many 	 :notification
  attachment :image

  validates :title, presence: true, length: { minimum: 2, maximum: 30 }
  validates :memory, length: { maximum: 200 }

  def flower_by?(user)
    flowers.where(user_id: user.id).exists?
    end
end
