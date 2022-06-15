class Public::LikesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    @like = current_user.likes.new(article_id: @article.id)
    @like.save
    # 自分の記事へのいいねは通知しない
    if @article.user_id != current_user.id
      @article.create_notification_like!(current_user, @like.id)
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @like = current_user.likes.find_by(article_id: @article.id)
    @like.destroy
  end

end
