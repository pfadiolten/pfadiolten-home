class HomePresenter < ApplicationPresenter
  attr_accessor :old_events,
                :news,
                :articles,
                :albums

  def articles_and_albums
    (articles + albums).sort_by(&:created_at).reverse
  end
end