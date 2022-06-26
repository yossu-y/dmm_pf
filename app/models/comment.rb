class Comment < ApplicationRecord
  
  # リレーション
  
  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy

  # リレーション
  
  validates :comment, presence: true, length: {in: 2..150}

end
