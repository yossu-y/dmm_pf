class Admin::SearchesController < ApplicationController

  def search
    @keyword = params[:range]

    if @keyword == "ユーザー"
      @users = User.search(params[:search], params[:keyword])
    elsif @keyword == "投稿"
      @articles = Article.where(is_draft: false).search(params[:search], params[:keyword])
    else @keyword = "コミュニティ"
      @groups = Group.search(params[:search], params[:keyword])
    end
  end

end
