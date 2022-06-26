class Public::NotificationsController < ApplicationController

  def index

    # 通知を確認後消すコード
    # current_user.passive_notifications.where(checked: false).where("created_at <= ?", Time.now.ago(1.day)).update_all(checked: true)
    # @notifications = current_user.passive_notifications.where(checked: false)
    # viewファイルの最後に記載する<% @notifications.update_all(checked: true) %>

    # 24時にリセットされるコード
    @notifications = current_user.passive_notifications.all
    # 確認後24時間で通知が消える
    @notifications.where( created_at: Time.zone.now.all_day )
    @notifications = @notifications.where( created_at: Time.zone.now.all_day )
    # checked: falseとtrueで確認済みか判断して通知マークを消す
    # 確認した通知はtrueに変わって消える
    @notifications.where( checked: false ).each do |notification|
      notification.update(checked: true)
    end
  end
end
