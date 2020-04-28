class Anniversary < ApplicationRecord
  belongs_to :portrait
  belongs_to :user
  validates :title, presence: true, length: { minimum: 2, maximum: 30 }
  validates :date, presence: true
  validates :memo, length: { maximum: 200 }
end
