class ApplicationController < ActionController::Base
# Configuration
  protect_from_forgery with: :exception

  # use pundit
  include Pundit

  # helper concerns
  include Has::Alerts

  # use the default responder
  self.responder = ApplicationResponder
  respond_to :html

# Callbacks
  after_action :verify_authorized,
               except: %i[index],
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

  def missing_rights
    flash[:failure] = I18n.t('errors.messages.missing_rights')
    redirect_back fallback_location: '/'
  end

  def present_all(query, **kwargs, &block)
    "#{query.model_name}Presenter::Collection".safe_constantize.present(present(query), **kwargs, &block)
  end

# static
  class << self
    def enforce_login!(options={})
      before_action :authenticate_user!, options
    end

    def enforce!(block_or_name, options={})
      condition =
        if block_or_name.is_a?(Symbol) || block_or_name.is_a?(String)
          ->{ send(block_or_name) }
        else
          block_or_name
        end

      before_action options do
        missing_rights unless instance_exec(&condition)
      end
    end
  end
end
