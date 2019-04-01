class HomeController < ApplicationController
  def index
    @home = HomePresenter.new(OpenStruct.new)
    @home.events   = policy_scope(Event.active)
    @home.news     = policy_scope(Article.pinned).order_by_release
    @home.articles = policy_scope(Article.not_pinned.limit(5)).order_by_release
    @home.albums   = policy_scope(Album.all.limit(5))
  end
end
