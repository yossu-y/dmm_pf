class Article < ApplicationRecord

  has_one_attached :image
  has_rich_text :body

  # リレーション

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :notifications, dependent: :destroy

  # リッチテキストはバリテーション不可

  validates :title, presence: true, on: :publicize
  # validates :body,  presence: true, on: :publicize

  # 投稿時のバリテーション
  with_options presence: true, on: :publicize do
    validates :title, length: { maximum: 50 }
    # validates :body, length: { minimum: 10 }
  end

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

  # タグ機能

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_article_tag = Tag.find_or_create_by(name: new)
      if new_article_tag.save
        self.tags << new_article_tag
      end
    end
  end

  def create_notification_like!(current_user, like_id)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visiter_id = ? and visited_id = ? and article_id = ? and action = ? ", current_user.id, user_id, id, "like"])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id,
        action: "like",
        like_id: like_id
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      article_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: "comment"
    )
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
