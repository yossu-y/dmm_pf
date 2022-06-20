class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]

    if @range == "User"
      @users = User.search(params[:search], params[:keyword])
    elsif @range == "Article"
      @articles = Article.search(params[:search], params[:keyword])
    else @range = "Tag"
      @tag_lists = Tag.search(params[:search], params[:keyword])
    end
  end

end
