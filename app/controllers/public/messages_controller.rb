class Public::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @message = current_user.messages.new(message_params)
    #@message.group_id = group.id
    @message.save
    redirect_to request.referer
  end

  def destroy
    @message = Message.find_by(id: params[:id], group_id: params[:group_id])
    @message.destroy
    redirect_to request.referer
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end

end
