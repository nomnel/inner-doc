class ArticlesController < ApplicationController
  def index
    @articles = Article.order('id DESC')
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
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
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to edit_article_path(@article), notice: t('article_was_successfully_updated')
    else
      render :edit
    end
  end

  private
    def article_params
      params.require(:article).permit(
        :title,
        :content
      )
    end
end
