class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications.all
    # created_at: Time.zone.now.all_day←通知後24時間でindexから消え
    # checked: falseとtrueで確認済みか判断して通知マークを消す
    @notifications.where(checked: false, created_at: Time.zone.now.all_day).each do |notification|
      notification.update(checked: true)
    end

  end

end
