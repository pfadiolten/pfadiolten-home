class HomeController < ApplicationController
  def index
    @home = HomePresenter.new(OpenStruct.new)
    @home.old_events = policy_scope(Old::Event.active)
    @home.news       = policy_scope(Old::Article.pinned).order_by_release
    @home.articles   = policy_scope(Old::Article.not_pinned.limit(5)).order_by_release
    @home.albums     = policy_scope(Album.all.limit(5))
  end
end
