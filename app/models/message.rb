class Message < ApplicationRecord

  belongs_to :user
  belongs_to :group

  validates :message, presence: true, length: {in: 2..150}

end
