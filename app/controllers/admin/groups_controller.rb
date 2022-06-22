class Admin::GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def room
    @group = Group.find(params[:id])
    @messages = @group.messages.all.order(created_at: :desc)
    @users = @group.users.all
  end

  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      redirect_to admin_groups_path, notice: "コミュニティを削除しました"
    end
  end

end
