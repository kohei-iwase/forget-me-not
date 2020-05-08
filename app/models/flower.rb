class Flower < ApplicationRecord
  belongs_to :user
  belongs_to :memory
  has_many :notifications, dependent: :destroy

  def create_notification_flower(current_user)
    # 現在献花されているかの検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and memory_id = ? and action = ? ", current_user.id, user_id, id, 'flower'])
    # 現在アクションの「献花」がされていない場合のみ通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        memory_id: id,
        visited_id: user_id,
        action: 'flower'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
end
end
