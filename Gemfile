source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# main rails gem
gem 'rails', '>= 5.1.5'

# database
gem 'sqlite3', '>= 1.3.13'

# app server
gem 'puma', '>= 3.7'

# uglifier for css & js
gem 'uglifier', '>= 1.3.0'

# css preprocessor
gem 'sass-rails', '>= 5.0'

# bootstrap - css framework
gem 'bootstrap-sass', '>= 3.3.7'

# font awesome - html/css icons
gem 'font-awesome-rails'

# client-side programming language, compiles to js
gem 'coffee-rails', '>= 4.2'

# jquery - js framework / core
gem 'jquery-rails', '>= 4.3.1'

# jquery - js framework / ui components
gem 'jquery-ui-rails', '>= 6.0.1'

# haml - HTML template language
gem 'haml-rails', '>= 1.0.0'

# authentication
gem 'devise', '>= 4.4.0'

# password encryption
gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'

# file upload & storage
gem 'carrierwave', '>= 1.2.1'

# error translations for carrierwave
gem 'carrierwave-i18n'

# image manipulation
# requires installation of ImageMagick (https://imagemagick.org) with all options.
gem 'mini_magick', '>= 4.8.0', require: false

# modular response extensions for controllers
gem 'responders', '>= 2.4.0'

# authorization
gem 'pundit', '>= 1.1.0'

# i18n for routes
gem 'route_translator', '>= 5.5.0'

# allows i18n entries to lookup other entries
gem 'i18n-recursive-lookup', '>= 0.0.5'

# customizable form builder
gem 'simple_form', '>= 3.5.0'

# HTML select input replacement
gem 'select2-rails', '>= 4.0.3'

# HTML datetime input for bootstrap
gem 'bootstrap3-datetimepicker-rails', '>= 4.17.47'

# WYSIWYG text editor
gem 'tinymce-rails', '>= 4.7.4'
gem 'tinymce-rails-langs', '>= 4.20160310'

# JS datetime library, required by 'bootstrap3-datetimepicker-rails'
gem 'momentjs-rails', '>= 2.17.1'

# extends the mail generators with encoding capability
gem 'actionview-encoded_mail_to', '>= 1.0.9'

# sanitize HTML values in models
gem 'sanitize', '>= 4.5.0'

# pagination in in activrecord-queries
gem 'kaminari', '>= 1.1.1'

# global Settings configurable via yml-files
gem 'config', '>= 1.6.1'

# create HTML calendars, including rails helpers
gem 'simple_calendar', '>= 2.0'

# image gallery
gem 'hermitage', '>= 0.0.7'

# openstreetmap.org javascript framework
gem 'leaflet-rails', '>= 1.3.1'

gem 'rubyzip'

# gem 'tui-editor-rails', path: '../tui-editor-rails'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # better error view in browser
  gem 'better_errors'

  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-passenger', '>= 0.1.1'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
end

group :development do
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.13'

  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
