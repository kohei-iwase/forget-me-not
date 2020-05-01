class Portrait < ApplicationRecord
  
  belongs_to :user

  #思い出
  has_many  :memories, dependent: :destroy

  #献花（アルバム）
  has_many  :bouquets, dependent: :destroy

  #命日
  has_many :anniversaries, dependent: :destroy

  #通知（献花用）
  has_many   :notifications

  attachment :image
  # バリデーション
  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :more_about_me, length: { maximum: 200 }
  # validate :picture_size

  # 献花したユーザーが存在するか？
  def bouquet_by?(user)
    bouquets.where(user_id: user.id).exists?
  end

  #献花の通知メソッド
  def create_notification_bouquet(current_user)
     #現在献花されているかの検索
    temp = Notification.where(["visiter_id = ? and visited_id = ? and portrait_id = ? and action = ? ", current_user.id, user_id, id, 'bouquet'])
     #現在アクションの「献花」がされていない場合のみ通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        portrait_id: id,
        visited_id: user_id,
        action: 'bouquet'
      )
       #自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  private

  # アップロードされた画像のサイズをバリデーションする
  # def picture_size
  #   if picture.size > 5.megabytes
  #     errors.add(:picture, "should be less than 5MB")
  #   end
  # end
end
