require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PfadioltenHome
  class Application < Rails::Application
    config.i18n.default_locale = :de

    config.time_zone = 'Zurich'
    config.active_record.default_timezone = :local

    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
  end
end
