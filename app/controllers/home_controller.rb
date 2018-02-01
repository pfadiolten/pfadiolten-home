class HomeController < ApplicationController
  def index
    @events = policy_scope(Event.active)
    authorize @events

    @news = policy_scope(Article.pinned).order_by_release
    authorize @news

    @articles = policy_scope(Article.not_pinned.limit(10)).order_by_release
    authorize @articles
  end
end
