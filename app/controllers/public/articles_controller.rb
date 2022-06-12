class Public::ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.all.order(created_at: :desc)
    @tag_list = Tag.all
    @groups = Group.all
  end

  def new
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
    if @article.save
      @article.save_tag(tag_list)
      redirect_to articles_path
    else
      @articles = Article.all
      render "new"
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article)
    else
      render "edit"
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

