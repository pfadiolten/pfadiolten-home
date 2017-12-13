source 'https://rubygems.org'

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
