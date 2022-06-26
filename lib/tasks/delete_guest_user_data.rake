namespace :delete_guest_user_data do
  desc "delete_guest_user_data"
    task destroy: :environment do
      user = User.find_by(email: "guest@example.com")
       user.articles.destroy_all
       user.comments.destroy_all
       user.group_users.destroy_all
       user.messages.destroy_all
    end
end
