class Admin::MessagesController < ApplicationController

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    redirect_to request.referer, notice: "メッセージを削除しました"
  end

end
