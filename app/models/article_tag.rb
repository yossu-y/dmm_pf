class ArticleTag < ApplicationRecord

  # リレーション
  belongs_to :tag
  belongs_to :article

  # リレーション

  validates :article_id, presence: true
  validates :tag_id, presence: true

end
