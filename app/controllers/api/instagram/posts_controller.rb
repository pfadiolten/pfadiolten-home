class Api::Instagram::PostsController < ApplicationController
  def recent
    @posts = InstagramApi
      .user(Settings.social.instagram_id)
      .recent_media.data.first(5)
      .map { |it| Api::Instagram::PostPresenter.new(it) }

    render layout: false
  end
end
