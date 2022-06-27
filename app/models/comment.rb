class Comment < ApplicationRecord

  # リレーション
  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

  # バリテーション
  validates :comment, presence: true, length: { maximum: 140 }

end
