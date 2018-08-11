class Api::Instagram::PostPresenter < ApplicationPresenter
  def embedded(include_script=true)
    response = HTTParty.get("https://api.instagram.com/oembed?url=#{link}&omitscript=#{!include_script}")
    if response.ok?
      [ JSON.parse(response.body)['html'].html_safe, nil ]
    else
      #TODO show nice error
      [ nil, response.body.to_s ]
    end
  end

  def policy_class
    Api::Instagram::PostPolicy
  end

  class Collection < ApplicationPresenter::Collection
    def policy_class
      Api::Instagram::PostPolicy
    end
  end
end