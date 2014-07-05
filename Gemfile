source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
group :development, :test do 
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.0.0'
end

group :development do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'guard-rspec', require: false
end

# Styles and front-end stuff
gem 'sass-rails', '~> 4.0.0'
gem 'compass-rails'
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'slim-rails' #use SLIM markup instead of .erb
gem 'mobile-fu' #use mobile-fu to detect mobile devices

# SEO
gem 'friendly_id', '~> 5.0.0' #use friendly URLs
#gem "dynamic_sitemaps"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Javascript stuff
gem 'coffee-rails', '~> 4.0.0'
gem 'gon'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# ActiveRecord Plugins
gem 'devise'
gem 'omniauth-facebook'
gem 'fb_graph'
#gem 'koala'
gem 'merit'

# Geocoding
gem 'geocoder'

# Pagination
gem 'kaminari'

# Image attachments
gem "paperclip", "~> 3.0"

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development
group :production do
  gem 'rails_12factor'
  gem 'pg'
  gem 'aws-sdk'
end

group :test do
  gem 'capybara'
end

ruby '2.0.0'
# Use debugger
# gem 'debugger', group: [:development, :test]
