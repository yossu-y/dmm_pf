class Message < ApplicationRecord

  belongs_to :user
  has_one :group

  validates :message, presence: true, length: {in: 2..150}

end
