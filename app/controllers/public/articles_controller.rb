class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.where(is_draft: false).order(updated_at: :desc)
    # タグの多い順に並べ替えたい
    @tag_lists = Tag.all
    @groups = Group.all.order(updated_at: :desc)
  end

  def new
    @articles = Article.where(is_draft: true)
    @article = Article.new
    @tag = Tag.new
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @article_tags = @article.tags
  end

  def edit
    @article = Article.find(params[:id])
    @tag_list = @article.tags.pluck(:name).join("、")
  end

  def create
    @article = current_user.articles.new(article_params)
    tag_list = params[:article][:tag_name].split("、").uniq
    # ActiveRecord::Base.transaction do
    flash[:alert] = "※10文字以上のタグは削除しました" if tag_list.any? { |tag| tag.length >= 21 }
    if params[:post]
      if @article.save(context: :publicize)
        @article.save_tag(tag_list)
        redirect_to articles_path, notice: "記事を投稿しました！"
      else
        @articles = Article.all
        render "new"
      end
    else
      if @article.update(is_draft: true)
        redirect_to draft_path, notice: "下書きに保存しました！"
      else
        render "new"
      end
    end
    # end
  # rescue => e
      # pp @article
      # pp e.message
      # pp @article.errors
      # @article.errors.add('タグ', e.message )

      # render "new"
  end

  def update
    @article = Article.find(params[:id])
    tag_list = params[:article][:tag_name].split("、").uniq
    flash[:alert] = "※10文字以上のタグは削除しました" if tag_list.any? { |tag| tag.length >= 21 }
    # 下書きを公開
    if params[:publicize_draft]
      #@article.attributes = article_params
      @article.attributes = article_params.merge(is_draft: false)
      if @article.save(context: :publicize)
        @article.save_tag(tag_list)
        redirect_to article_path(@article), notice: "下書きを公開しました！"
      else
        render "edit"
      end
    # 公開中の記事を更新
    elsif params[:update_post]
      @article.attributes = article_params.merge(is_draft: false)
      if @article.save(context: :publicize)
        @article.save_tag(tag_list)
        redirect_to article_path(@article), notice: "投稿を更新しました！"
      else
        @article.is_draft = true
        render "edit"
      end
    # 下書きを更新
    else
      if @article.update(article_params)
        @article.save_tag(tag_list)
        redirect_to draft_path, notice: "下書きを更新しました"
      else
        render "edit"
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    # ページの変遷先を確認
    redirect_to articles_path, notice: "記事を削除しました！"
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @tag_articles = @tag.articles.all
  end

  def draft
    @articles = Article.where(is_draft: true).order(updated_at: :desc)
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :is_draft, :image)
  end

  def correct_user
    @article = Article.find(params[:id])
    @user = @article.user
    redirect_to(articles_path) unless @user == current_user
  end

end

