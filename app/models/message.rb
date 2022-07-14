class Message < ApplicationRecord

  default_scope -> { order(created_at: :desc) }

  # アソシエーション
  belongs_to :user
  belongs_to :group

  # バリテーション
  validates :message, presence: true, length: { maximum: 500 }

end
