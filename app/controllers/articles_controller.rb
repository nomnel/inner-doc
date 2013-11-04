class ArticlesController < ApplicationController
  before_action :require_login
  before_action :set_article, only: [:edit, :update, :destroy]

  def index
    if current_user.admin?
      @articles = Article.order('id DESC')
    else
      @articles = current_user.articles.order('id DESC')
    end
  end

  def new
    @article = Article.new
    @article.article_users.build
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_path, notice: t('article_was_successfully_created')
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path, notice: t('article_was_successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    if current_user.admin?
      @article.destroy
      redirect_to articles_url, notice: t('article_was_successfully_deleted')
    else
      redirect_to articles_url, notice: t('admin_user_only')
    end
  end

  private
    def set_article
      if current_user.admin?
        @article = Article.find(params[:id])
      else
        @article = current_user.articles.find(params[:id])
      end
    end

    def article_params
      params.require(:article).permit(
        :title,
        :content,
        article_users_attributes: [:id, :user_id, :_destroy]
      )
    end
end
