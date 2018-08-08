class PostPresenter < ApplicationPresenter
  require 'net/http'

  def embedded
    uri = URI("https://api.instagram.com/oembed?url=#{link}")
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess)
      [ res.body.html.html_safe, nil ]
    else
      #TODO show nice error
      [ nil, res.body.to_s ]
    end
  end
end