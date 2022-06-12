class ArticleTag < ApplicationRecord

  belongs_to :tag
  belongs_to :article

  validates :article_id, presence: true
  validates :tag_id, presence: true

end
