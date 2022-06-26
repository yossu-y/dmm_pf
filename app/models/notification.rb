class Notification < ApplicationRecord

  # 新着順に表示
  default_scope -> { order(created_at: :desc) }
  
  # リレーション
  belongs_to :article, optional: true
  belongs_to :comment, optional: true
  belongs_to :like, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
