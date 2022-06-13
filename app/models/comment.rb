class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

end
