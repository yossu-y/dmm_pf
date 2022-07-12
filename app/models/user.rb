class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_one_attached :profile_image

  # リレーション

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy
  has_many :messages, through: :groups, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :contacts, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  # 相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # バリテーション
  validates :screen_name, length: { maximum: 30 }, presence: true
  validates :introduction, length: { maximum: 350 }

  def get_profile_image
    (profile_image.attached?)? profile_image: "no-image-icon.jpg"
  end

  # フォロー機能のメソッド

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  # 検索機能のメソッド

  def self.search(search, keyword)
    if search != ""
      @user = User.where(['screen_name LIKE(?)', "%#{keyword}%"])
    else
      @user = User.all
    end
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, "follow"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: "follow"
      )
      notification.save if notification.valid?
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # deviseのuserカラムに name を追加している場合は以下のコメントアウトも追記します
      user.name = auth.info.name
      user.screen_name = auth.info.screen_name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  # ゲストログインメソッド
  def self.guest
    find_or_create_by!(name: "guestuser", screen_name: "guest", email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # 退会済みユーザーをブロック
  def active_for_authentication?
    super && (is_deleted == false)
  end

end
