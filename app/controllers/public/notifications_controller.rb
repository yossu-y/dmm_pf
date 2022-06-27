class Public::NotificationsController < ApplicationController

  def index

    # 通知を確認後消すコード
    # current_user.passive_notifications.where(checked: false).where("created_at <= ?", Time.now.ago(1.day)).update_all(checked: true)
    # @notifications = current_user.passive_notifications.where(checked: false)
    # viewファイルの最後に記載する<% @notifications.update_all(checked: true) %>

    # 24時にリセットされるコード
    @notifications = current_user.passive_notifications.all
    # index画面を開くとchecked: trueに変わって通知マークが消える
    @notifications.where( checked: false ).each do |notification|
      notification.update(checked: true)
    end
    # 24時に通知が消える
    @notifications.where( created_at: Time.zone.now.all_day )
    @notifications = @notifications.where( created_at: Time.zone.now.all_day )
  end

end
