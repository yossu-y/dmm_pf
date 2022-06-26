class Comment < ApplicationRecord

  # リレーション

  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

  # リレーション

  validates :comment, presence: true, length: { maximum: 140 }

end
