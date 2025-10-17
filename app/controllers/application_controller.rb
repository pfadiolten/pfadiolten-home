class ApplicationController < ActionController::Base
  include ApplicationController::Auth

# Configuration
  protect_from_forgery with: :exception

  # helper concerns
  include Has::Alerts

  # use the default responder
  self.responder = ApplicationResponder
  respond_to :html
  
  # Handle 404
  rescue_from ActionController::RoutingError, with: :show_not_found

  def show_not_found
    skip_policy_scope
    skip_authorization
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
  end

# Actions
protected
  # produce a 404
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def present_all(query, **kwargs, &block)
    "#{query.model_name}Presenter::Collection".safe_constantize.present(present(query), **kwargs, &block)
  end
end
