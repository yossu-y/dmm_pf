class Admin::SearchesController < ApplicationController

  def search
    @keyword = params[:range]

    if @keyword == "User"
      @users = User.search(params[:search], params[:keyword])
    elsif @keyword == "Article"
      @articles = Article.search(params[:search], params[:keyword])
    else @keyword = "Group"
      @groups = Group.search(params[:search], params[:keyword])
    end
  end

end
