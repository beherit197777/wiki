class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_category
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = @category.articles
  end

  def show; end

  def new
    @article = @category.articles.new
  end

  def create
    @article = @category.articles.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to [@category, @article], notice: "Статья успешно создана."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to [@category, @article], notice: "Статья обновлена."
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to category_articles_path(@category), notice: "Статья удалена."
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_article
    @article = @category.articles.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :category_id, tag_ids: [])
  end
end
