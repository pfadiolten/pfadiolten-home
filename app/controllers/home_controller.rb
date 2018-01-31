class HomeController < ApplicationController
  def index
    @events = policy_scope(Event.active)
    authorize @events

    @articles = policy_scope(Article.page(params[:article_page]).per(5)).order_by_release
    authorize @articles
  end
end
