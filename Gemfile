source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# main rails gem
gem 'rails', '~> 5.1.4'

# database
gem 'sqlite3'

# app server
gem 'puma', '~> 3.7'

# uglifier for css & js
gem 'uglifier', '>= 1.3.0'

# css preprocessor
gem 'sass-rails', '~> 5.0'

# bootstrap - css framework
gem 'bootstrap-sass'

# font awesome - html/css icons
gem 'font-awesome-rails'

# client-side programming language, compiles to js
gem 'coffee-rails', '~> 4.2'

# jquery - js framework / core
gem 'jquery-rails'

# jquery - js framework / ui components
gem 'jquery-ui-rails'

# password encryption
gem 'bcrypt', '~> 3.1.7', platforms: %i[ruby]

# HTML template language
gem 'haml-rails'

# authentication
gem 'devise'

# file upload & storage
gem 'carrierwave'

# image manipulation
# requires installation of ImageMagick (https://imagemagick.org) or GraphicsMagick (http://graphicsmagick.org)
gem 'mini_magick', require: false

# modular response extensions for controllers
gem 'responders'

# authorization
gem 'pundit'

# i18n for routes
gem 'route_translator'

# allows i18n entries to lookup other entries
gem 'i18n-recursive-lookup'

# customizable form builder
gem 'simple_form'

# HTML select input replacement
gem 'select2-rails'

# HTML datetime input for bootstrap
gem 'bootstrap3-datetimepicker-rails'

# JS datetime library, required by 'bootstrap3-datetimepicker-rails'
gem 'momentjs-rails'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'capybara', '~> 2.13'

  gem 'selenium-webdriver'

  # better error view in browser
  gem 'better_errors'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
