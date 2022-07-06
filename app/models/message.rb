class Message < ApplicationRecord

  default_scope -> { order(created_at: :desc) }

  # リレーション
  belongs_to :user
  belongs_to :group

  # バリテーション
  validates :message, presence: true

end
