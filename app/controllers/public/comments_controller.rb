class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = @article.id
    if @comment.save
    else
      # コメント失敗時メッセージ
      redirect_to request.referer
      flash[:alert] = "コメントは140文字以内で入力してください"
    end
    # 自分の記事へのコメントは通知しない
    if @article.user_id != current_user.id
      @article.create_notification_comment!(current_user, @comment.id)
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
