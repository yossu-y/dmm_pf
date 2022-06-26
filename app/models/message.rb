class Message < ApplicationRecord

  # リレーション

  belongs_to :user
  belongs_to :group


  validates :message, presence: true, length: { maximum: 300 }

end
