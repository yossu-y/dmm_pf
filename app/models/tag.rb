class Tag < ApplicationRecord

  has_many :article_tags, dependent: :destroy, foreign_key: "tag_id"
  has_many :articles, through: :article_tags

  validates :name, uniqueness: true, length: {maximum: 10}

  def self.search(search, keyword)
    if search != ""
      @tag = Tag.where(['name LIKE(?)', "%#{keyword}%"])
    else
      @tag = Tag.all
    end
  end

end
