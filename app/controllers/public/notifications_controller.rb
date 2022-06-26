class Public::NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications.all
    # 送られた後24時間で通知が消える
    @notifications.where( created_at: Time.zone.now.all_day )
    # checked: falseとtrueで確認済みか判断して通知マークを消す
    # 確認した通知はtrueに変わって通知マークが消える
    @notifications.where( checked: false ).each do |notification|
      notification.update(checked: true)
    end
  end

end
