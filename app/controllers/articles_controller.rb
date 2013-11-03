class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :destroy]
  def index
    @articles = Article.order('id DESC')
  end

  def new
    @article = Article.new
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
      redirect_to edit_article_path(@article), notice: t('article_was_successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: t('article_was_successfully_deleted')
  end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(
        :title,
        :content
      )
    end
end
