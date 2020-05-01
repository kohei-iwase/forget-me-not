class Notification < ApplicationRecord
  # 通知は新着順に
  default_scope -> { order(created_at: :desc) }

  #アルバム
  belongs_to :portrait, optional: true

  #献花（アルバム）
  belongs_to :bouquet, optional: true

  #思い出
  belongs_to :memory, optional: true

  #献花（思い出）
  belongs_to :flower, optional: true

  #通知用
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
