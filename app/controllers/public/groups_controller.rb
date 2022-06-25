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
    # 退会ユーザーを表示しない
    @group_users = @group.users.where(is_deleted: false)
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      redirect_to group_path(@group), notice: "コミュニティを作成しました！"
    else
      render "new"
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: "コミュニティを更新しました！"
    else
      render "edit"
    end
  end

  def destroy
    # 削除機能は管理者のみ実装
  end

  def room
    @group = Group.find(params[:id])
    @messages = @group.messages.all
    # 退会ユーザーは表示しない
    @group_users = @group.users.where(is_deleted: false)
  end

  def group_users
    @group = Group.find(params[:id])
    @users = @group.users.where(is_deleted: false)
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner.id == current_user.id
      redirect_to groups_path
    end
  end

end
