class ArticlesController < ApplicationController
  before_action :load_article, except: %i[index new create]

  enforce_login! except: %i[index show]

  def index
    page = params[:page]
    @articles = policy_scope(Article.page(page)).order_by_release
    authorize @articles
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
    id = params[:id].split('@')[1] || not_found
    @article = Article.find_by(id: id) || not_found
    authorize @article
  end

private
  def article_params
    p = params.require(:article).permit(
      :title,
      :summary,
      :text,
      :image,
      :is_pinned,
      :pinned_till,
      :remove_image,
      image_attributes: [
        :id,
        :_destroy,
        :file,
      ]
    )

    # TODO remove after migrating to ActiveStorage
    p.tap do |attrs|
      avatar_attrs = attrs[:image_attributes] || {}
      avatar_attrs[:old_file] = avatar_attrs[:file]
    end
  end
end
