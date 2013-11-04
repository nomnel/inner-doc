class ArticlesController < ApplicationController
  before_action :require_login
  before_action :set_article, only: [:edit, :update]

  def index
    @articles = current_user.articles.order('id DESC')
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

  private
    def set_article
      @article = current_user.articles.find(params[:id])
    end

    def article_params
      params.require(:article).permit(
        :title,
        :content,
        article_users_attributes: [:id, :user_id, :_destroy]
      )
    end
end
