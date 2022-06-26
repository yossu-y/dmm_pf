class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "ユーザー"
      # whereを使って退会済みユーザーを非表示
      @users = User.where(is_deleted: false).search(params[:search], params[:keyword])
    elsif @range == "投稿"
      @articles = Article.search(params[:search], params[:keyword])
    else @range = "コミュニティ"
      @groups = Group.search(params[:search], params[:keyword])
    end
  end

end
