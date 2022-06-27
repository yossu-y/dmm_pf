class Like < ApplicationRecord

  # リレーション

  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

  # バリテーション
  validates_uniqueness_of :article_id, scope: :user_id

end
