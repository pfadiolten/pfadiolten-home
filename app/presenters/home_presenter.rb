class HomePresenter < ApplicationPresenter
  attr_accessor :events,
                :articles,
                :albums

  def articles_and_albums
    (articles + albums).sort_by(&:created_at).reverse
  end
end