class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :articles, dependent: :destroy


  def get_profile_image
    (profile_image.attached?)? profile_image: "no-image-icon.jpg"
  end


  # ゲストログインメソッド
  def self.guest
    find_or_create_by!(name: "guestuser", screen_name: "guest", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

end
