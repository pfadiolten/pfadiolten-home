class HomeController < ApplicationController
  def index
    @home = HomePresenter.new(OpenStruct.new)

    @home.events   = policy_scope(Event.active)
    @home.articles = policy_scope(Article.limit(5)).order_by_release
    @home.albums   = policy_scope(Album.limit(3))

    authorize @home.events
    authorize @home.articles
    authorize @home.albums
  end

  def calendar
    skip_policy_scope
    skip_authorization
  end
end
