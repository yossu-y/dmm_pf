class Admin::MessagesController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    redirect_to request.referer, notice: "メッセージを削除しました"
  end

end
