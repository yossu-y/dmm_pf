class Like < ApplicationRecord

  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

  valodates_uniquness_of :article_id, scope: :user_id

end
