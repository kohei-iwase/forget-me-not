class Flower < ApplicationRecord
  belongs_to :user
  belongs_to :memory
  has_many 	 :notification
end
