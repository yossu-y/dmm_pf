class Message < ApplicationRecord

  # リレーション
  belongs_to :user
  belongs_to :group

  # バリテーション
  validates :message, presence: true

end
