class Api::Instagram::PostsController < ApplicationController
  def recent
    @posts =
      presenter.present_all(
        api.recent_media.data.first(5)
      )

    authorize(@posts)

    render layout: false
  end

private
  def api(id: Settings.social.instagram_id)
    InstagramApi.user(id)
  end

  def presenter
    Api::Instagram::PostPresenter
  end
end
