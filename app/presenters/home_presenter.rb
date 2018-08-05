require 'net/http'

class HomePresenter < ApplicationPresenter
  attr_accessor :events,
                :news,
                :articles,
                :albums

  def articles_and_albums
    (articles + albums).sort_by(&:created_at).reverse
  end

  def recent_instagram_posts(limit: 5)
    InstagramApi.user(Settings.social.instagram_id).recent_media.data.first(5).map { |it| InstagramPost.new(it) }
  end

  class InstagramPost
    def initialize(data)
      @data = data
    end

    attr_reader :data

    def link
      data.link
    end
  end
end