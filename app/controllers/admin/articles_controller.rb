class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @articles = Article.where(is_draft: false)
  end

  def show
    @article = Article.find(params[:id])
    @article_tags = @article.tags
  end

  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      redirect_to admin_articles_path, notice: "投稿を削除しました。"
    end
  end

end
