class ApplicationController < ActionController::Base
# Configuration
  protect_from_forgery with: :exception

  # use pundit
  include Pundit

  # use the default responder
  self.responder = ApplicationResponder

# Callbacks
  after_action :verify_authorized,
               unless: ->{ is_a? SessionsController }

  after_action :verify_policy_scoped,
               only: %i[index],
               unless: ->{ is_a? SessionsController }

# Actions
protected
  # produce a 404
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
