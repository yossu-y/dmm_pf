class Group < ApplicationRecord

  has_one_attached :image

  # アソシエーション
  belongs_to :owner, class_name: "User"
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users
  has_many :messages, dependent: :destroy

  # バリテーション
  validates :name, presence: true, length: {maximum: 50}
  validates :introduction, presence: true, length: {in: 10..800}

  def self.search(search, keyword)
    if search != ""
      @group = Group.where(["name LIKE(?)", "%#{keyword}%"])
    else
      @group = Group.all
    end
  end

  # グループ作成者か判断する
  def is_owned_by?(user)
    owner.id == user.id
  end

  # 参加中か判断する
  def includesUser?(user)
    group_users.exists?(user_id: user.id)
  end

  def get_image
    (image.attached?)? image: "no_image.jpg"
  end

end
