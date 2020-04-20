class Portrait < ApplicationRecord
	belongs_to 	:user
	has_many	:memories, dependent: :destroy
	has_many	:bouquets, dependent: :destroy
	has_many 	:anniversaries, dependent: :destroy
	attachment 	:image

  #バリデーション
	validates :name, presence: true, length: {minimum: 2, maximum: 30}
  validates :more_about_me, length: {maximum: 200}

 #献花したユーザーが存在するか？
	def bouquet_by?(user)
          bouquets.where(user_id: user.id).exists?
  end

 #誰によって献花されたか？
  def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
          portrait_id: id,
          visited_id: user_id,
          action: "bouquet"
        )
        notification.save if notification.valid?
  end

  def create_notification_bouquet!(current_user, bouquet_id)
        # 自分以外に献花している人をすべて取得し、全員に通知を送る
        temp_ids = Bouquet.select(:user_id).where(portrait_id: id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_bouquet!(current_user, bouquet_id, temp_id['user_id'])
        end
        # まだ誰も献花していない場合は、投稿者に通知を送る
        save_notification_bouquet!(current_user, bouquet_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
        # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
        notification = current_user.active_notifications.new(
          item_id: id,
          comment_id: comment_id,
          visited_id: visited_id,
          action: 'comment'
        )
        # 自分の投稿に対するコメントの場合は、通知済みとする
        if notification.visiter_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
     end





end
