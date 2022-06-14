class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.where(is_draft: false).order(created_at: :desc)
    @tag_list = Tag.all
    @groups = Group.all
  end

  def new
    @articles = Article.where(is_draft: true).order(created_at: :desc)
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
    tag_list = params[:article][:tag_name].split("、")
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
        redirect_to user_path(current_user), notice: "下書きに保存しました！"
      else
        render "new"
      end
    end
  end

  def update
    # 記事を公開の処理は上手くいっている。他はまだ。。
    @article = Article.find(params[:id])
    # 投稿を更新
    if params[:publicize_draft]
      @article.attributes = article_params
      if @article.save(context: :publicize)
        redirect_to root_path
      else
        render "edit"
      end
    # 記事を公開
    elsif params[:update_post]
      @article.attributes = article_params.merge(is_draft: false)
      if @article.save(context: :publicize)
        redirect_to article_path(@article), notice: "記事を更新しました！"
      else
        @article.is_draft = true
        render "edit"
      end
    # 下書きを更新
    else
      if @article.update(article_params)
        redirect_to article_path(@article)
      else
        render "edit"
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @tag_articles = @tag.articles.all
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

