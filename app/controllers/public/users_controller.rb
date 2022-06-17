class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    # ユーザーの投稿した記事一覧
    @articles = @user.articles.all.order(created_at: :desc)
    # ユーザーのいいねした記事一覧
    @likes = @user.likes.all.order(created_at: :desc)
    # pluckでarticle_idのみ取得
    @like_articles = Article.find(@likes.pluck(:article_id))
    # 参加中のグループ一覧
    @groups = @user.groups.all.order(created_at: :desc)
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました！"
    else
      render "edit"
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会処理が完了しました。"
  end

  private

  def user_params
    params.require(:user).permit(:screen_name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end
