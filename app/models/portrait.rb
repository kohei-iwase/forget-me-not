class Portrait < ApplicationRecord
	belongs_to 	:user
	has_many	:memories, dependent: :destroy
	has_many	:bouquets, dependent: :destroy
	attachment 	:image

	validates :name, presence: true

	def bouquet_by?(user)
          bouquets.where(user_id: user.id).exists?
    end

  #   def create_notification_bouquet!(current_user)
  #   # すでに「いいね」されているか検索
  #   temp = Notification.where(["user_id = ? and user_id = ? and portrait_id = ? and action = ? ", current_user.id, user_id, id, 'bouquet'])
  #   # いいねされていない場合のみ、通知レコードを作成
  #   if temp.blank?
  #     notification = current_user.active_notifications.new(
  #       portrait_id: id,
  #       user_id: user_id,
  #       action: 'bouquet'
  #     )
  #     # 自分の投稿に対するいいねの場合は、通知済みとする
  #     if notification.user_id == notification.user_id
  #       notification.checked = true
  #     end
  #     notification.save if notification.valid?
  #   end
  # end
end
