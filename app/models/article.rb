class Article < ApplicationRecord

  has_one_attached :image
  has_rich_text :body

  # リレーション

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  validates :title, presence: true, length: {maximum: 50}
  validates :body,  presence: true, length: {maximum: 1500}

  def get_image
    (image.attached?)? image: "no_image.jpg"
  end


  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.search(search, keyword)
    if search != ""
      @article = Article.where(['title LIKE(?)', "%#{keyword}%"])
    else
      @article = Article.all
    end
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_article_tag = Tag.find_or_create_by(name: new)
      self.tags << new_article_tag
    end
  end

end
