class Guestuser::DataGuest

  # guestuserの投稿を削除
  def self.data_reset
    user = User.find_by(email: "guest@example.com")
    user.articles.destroy_all
    user.comments.destroy_all
  end
end
