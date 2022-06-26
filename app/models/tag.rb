class Tag < ApplicationRecord

  # リレーション

  has_many :article_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :articles, through: :article_tags

  # タグの文字数制限

  validates :name, length: {maximum: 20}

end
