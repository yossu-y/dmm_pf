class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true, length: {in: 2..150}

end
