class ArticlesController < ApplicationController
  before_action :load_article, except: %i[index new create]

  enforce_login! except: %i[index show]

  def index
    page = params[:page]
    @articles = policy_scope(Article.page(page)).order_by_release
    @pinned_articles =
      if page.nil? || page == 1
        @articles = @articles.where.not('pinned?': true)

        policy_scope(Article.pinned).order_by_release
      else
        []
      end
    authorize @articles
    authorize @pinned_articles
  end

  def show
  end

  def new
    @article = Article.new(author: current_user)
    authorize @article
  end

  def create
    @article = Article.new(article_params.merge(author: current_user))
    authorize @article
    @article.save
    respond_with @article
  end

  def edit
  end

  def update
    @article.update(article_params)
    respond_with @article
  end

  def destroy
    @article.destroy
    respond_with @article, action: 'edit'
  end

protected
  def load_article
    @article = Article.find_by(id: params[:id]) || not_found
    authorize @article
  end

private
  def article_params
    params.require(:article).permit(
      :title,
      :text,
      :image,
      :is_pinned,
      :pinned_till,
      :remove_image,
    )
  end
end
