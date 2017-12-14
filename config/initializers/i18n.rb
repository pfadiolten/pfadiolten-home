require 'i18n/backend/recursive_lookup'

I18n::Backend::Simple.send(:include, I18n::Backend::RecursiveLookup)

Rails.application.config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]

