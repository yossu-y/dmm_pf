class Article < ApplicationRecord

  has_one_attached :image
  has_rich_text :body

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

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

end
