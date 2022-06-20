class Tag < ApplicationRecord

  has_many :article_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :articles, through: :article_tags

  # タグの文字数制限をつけたい
  # validates :name, uniqueness: true, length: {maximum: 10}

end
