class RobotsController < ApplicationController
  def index
    skip_policy_scope

    view = if Rails.env.production?
      'robots.txt'
    else
      'robots.dev.txt'
    end

    render view, layout: false, content_type: 'text/plain', formats: :txt
  end
end