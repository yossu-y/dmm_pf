class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @article = Article.new
    @groups = Group.all.order(updated_at: :desc)
  end

  def new
    @group = Group.new
  end

  def show
    @article = Article.new
    @group = Group.find(params[:id])
    @users = @group.users.all
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to groups_path, notice: "コミュニティを作成しました！"
    else
      render "new"
    end
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: "コミュニティを更新しました！"
    else
      render "edit"
    end
  end

  def destroy
    # 削除機能は実装未定
  end

  def room
    @group = Group.find(params[:id])
    @messages = @group.messages.all.order(created_at: :desc)
    @users = @group.users.all
  end

  def group_users
    @group = Group.find(params[:id])
    @users = @group.users.all
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner.id == current_user.id
      redirect_to groups_path
    end
  end

end
