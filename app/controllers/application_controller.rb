class ApplicationController < ActionController::Base
  include ApplicationController::Auth

# Configuration
  protect_from_forgery with: :exception

  # helper concerns
  include Has::Alerts

  # use the default responder
  self.responder = ApplicationResponder
  respond_to :html

# Actions
protected
  # produce a 404
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
