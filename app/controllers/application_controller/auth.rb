# Contains functionality for ApplicationController related to authorization and authentication.
module ApplicationController::Auth
  extend ActiveSupport::Concern

  include Pundit::Authorization

  included do
    # Callbacks
    after_action :verify_authorized,
                 except: %i[ index ],
                 unless: ->{ is_a? SessionsController }

    after_action :verify_policy_scoped,
                 only: %i[ index ],
                 unless: ->{ is_a? SessionsController }
  end

  def missing_rights
    flash[:failure] = I18n.t('errors.messages.missing_rights')
    redirect_back fallback_location: '/'
  end

  class_methods do
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