ruby '2.5.0'
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.11'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# interface with NDS API
gem 'nds_api', '0.1.23'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# to manage cache / memcache
# gem 'dalli'

# Server
gem 'puma'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', :require => 'rack/cors'

# Database
gem 'pg', '~> 0.18'

# Assets
gem 'slim-rails'

# NOTE: angular-rails-templates not yet compatible with sprockets >= 3.0
# https://github.com/pitr/angular-rails-templates/issues/93
gem 'angular-rails-templates' , '~> 1.0'
gem 'sprockets', '~> 3.0'
# Forked version of angular-rails-templates that works with sprockets >= 3.0
# gem 'angular-rails4-templates'

# Authentication manager
gem 'devise'
# Token auth for devise
gem 'devise_token_auth', '~>0.2.0'

# Email distribution
gem 'sendgrid-ruby'

source "https://rails-assets.org" do
  gem "rails-assets-angular-devise"
end

gem 'newrelic_rpm'

gem 'kaminari', '~> 1.1.1'

# Enforce dependency versions to avoid vulnerabilities
gem 'loofah', '~> 2.2.3'
gem 'rack', '~> 1.6.13'

group :development, :test do
  gem 'rb-readline'

  # `rails g rspec:install`
  gem 'rspec-rails'

  # `require 'should_not/rspec'` in rails_helper.rb
  gem 'should_not'

  gem 'faker'

  # `shoulda_helper.rb` and `require 'shoulda_helper'` in rails_helper.rb
  gem 'shoulda-matchers', '~> 3.0'

  # `rails generate teaspoon:install --coffee`
  gem 'teaspoon-jasmine'

  gem 'dotenv-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Error backtraces and interactive console
  gem 'better_errors'
  gem 'binding_of_caller'

  # Remove asset output from server logs
  gem 'quiet_assets'

  gem 'rubocop', require: false

  # Add a comment summarizing the current schema to the top or bottom of each models
  gem 'annotate'

  # `guard` to watch files and run tasks
  gem 'guard', '>= 2.2.2', require: false

  # guard notifications
  gem 'terminal-notifier-guard'

  # Livereload: https://mattbrictson.com/lightning-fast-sass-reloading-in-rails
  # Add `config.middleware.insert_after(ActionDispatch::Static, Rack::LiveReload)` to `config/environments/development.rb`
  # `guard init livereload`
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'rb-fsevent',       require: false

  gem 'phantomjs'

  # `guard init bundler`
  gem 'guard-bundler', require: false

  # `guard init rspec`
  gem 'guard-rspec', require: false

  # `guard init rubocop`
  gem 'guard-rubocop', require: false

  # `guard init teaspoon`
  gem 'guard-teaspoon', require: false

  # Debugging console
  gem 'pry-byebug'

  # Run git hooks
  gem 'overcommit'

  # Used by Overcommit to check best practices in Rails code
  gem 'rails_best_practices'
end

group :staging, :production do
  gem 'rails_12factor'
  gem 'le'
end
