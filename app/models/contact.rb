class Contact < ApplicationRecord

  # belongs_to :user

  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true, length: {in: 2..1000}

  enum subject: { like_user: 0, like_article: 1, like_comment: 2, like_group: 3, other: 4 }

end
