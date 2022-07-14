class Comment < ApplicationRecord

  default_scope -> { order(created_at: :desc) }

  # アソシエーション
  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

  # バリテーション
  validates :comment, presence: true, length: { maximum: 140 }

end
