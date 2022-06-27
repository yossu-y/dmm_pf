module Public::NotificationsHelper

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false, created_at: Time.zone.now.all_day)
  end

end
