class HomeController < ApplicationController
  def index
    @home = HomePresenter.new(OpenStruct.new)

    @home.events   = policy_scope(Event.active)
    @home.articles = policy_scope(Article.limit(5)).order_by_release
    @home.albums   = policy_scope(Album.all.limit(5))

    authorize @home.events
    authorize @home.articles
    authorize @home.albums
  end
end
