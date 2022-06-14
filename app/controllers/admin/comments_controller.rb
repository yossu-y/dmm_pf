class Admin::CommentsController < ApplicationController

  def destroy
    comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
    comment.destroy
    redirect_to request.referer
  end

end