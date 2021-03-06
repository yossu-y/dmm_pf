class Public::MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @message = Message.create({group_id: @group.id, message: params[:message][:message], user_id: current_user.id})
    # @message = current_user.messages.new(message_params)
    # @message.group_id = group.id
    # @message.save
    # redirect_to request.referer
  end

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.destroy
    # redirect_to request.referer
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end

end
