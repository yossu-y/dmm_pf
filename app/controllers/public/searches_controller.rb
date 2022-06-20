class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.search(params[:search], params[:keyword])
    elsif @range == "Article"
      @articles = Article.search(params[:search], params[:keyword])
    else @range = "Group"
      @groups = Group.search(params[:search], params[:keyword])
    end
  end

end
