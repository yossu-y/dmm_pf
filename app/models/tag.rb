class Tag < ApplicationRecord

  # アソシエーション
  has_many :article_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :articles, through: :article_tags

  # バリテーション
  validates :name, length: {maximum: 20}

end
