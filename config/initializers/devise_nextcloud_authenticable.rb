require 'devise/strategies/authenticatable'

module Devise
  module Models
    module NextcloudAuthenticatable
      extend ActiveSupport::Concern

      class_methods do
        def serialize_from_session(id, *_rest)
          self.find_by(id: id)
        end

        def serialize_into_session(record)
          [record.id]
        end
      end
    end
  end

  module Strategies
    class NextcloudAuthenticatable < Authenticatable
      def authenticate!
        return unless params.key?(:user)

        user = User.find_by_scout_name(scout_name)
        return fail(:invalid) if user.nil?

        service = NextcloudService.new
        response = service.login(username: scout_name, password: password)
        case
        when !response.ok?
          user.errors.add(:base, response.error)
          fail(:invalid)
        when !response.result
          fail(:invalid)
        else
          success!(user)
        end
      end

      def scout_name
        @_scout_name ||=
          params.dig(:user, :scout_name)
      end

      def password
        @_password ||=
          params.dig(:user, :password)
      end
    end
  end
end

Devise.add_module(
  :nextcloud_authenticatable,
  route:    :session,
  strategy: true,
)

Warden::Strategies.add(:nextcloud_authenticatable, Devise::Strategies::NextcloudAuthenticatable)