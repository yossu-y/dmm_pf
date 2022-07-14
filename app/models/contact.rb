class Contact < ApplicationRecord

  # アソシエーション
  belongs_to :user

  # バリテーション
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true
  validates :message, presence: true, length: {in: 2..500}


  enum subject: { like_user: 0, like_article: 1, like_comment: 2, like_group: 3, other: 4 }

  enum progress_status: { unsupported: 0 ,support: 1, already_supported: 2}

end

