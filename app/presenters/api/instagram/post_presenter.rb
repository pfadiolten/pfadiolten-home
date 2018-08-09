class PostPresenter < ApplicationPresenter
  def embedded
    response = HTTParty.get("https://api.instagram.com/oembed?url=#{link}")
    raise response.methods.to_s

    if res.is_a?(Net::HTTPSuccess)
      [ res.body.html.html_safe, nil ]
    else
      #TODO show nice error
      [ nil, res.body.to_s ]
    end
  end
end