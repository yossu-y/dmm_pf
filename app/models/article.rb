class Article < ApplicationRecord

  has_one_attached :image
  has_rich_text :body

  belongs_to :user

  validates :title, presence: true, length: {maximum: 50}
  validates :body,  presence: true, length: {maximum: 1500}

  def get_image
    (image.attached?)? image: "no_image.jpg"
  end

end
