class Bouquet < ApplicationRecord
  belongs_to :user
  belongs_to :portrait
  has_many 	 :notifications, dependent: :destroy
end
