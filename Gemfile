source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use sqlite3 as the database for Active Record
group :development, :test do 
  gem 'sqlite3'
  gem 'rspec-rails', '~> 3.0.0' # use RSpec as the testing framework
end

group :development do
  gem 'guard-rspec', require: false # allow guard to run just parts of the test suite instead of the whole thing
end

# Styles and front-end stuff
gem 'sass-rails', '~> 4.0.0' # use sass instead of normal css
gem 'compass-rails' # use compass for adttional css/scss tools
gem 'bootstrap-sass', '~> 3.0.3.0' #use Twitter Bootstrap 2 as the front-end css framework
gem 'slim-rails' #use SLIM markup instead of .erb
gem 'mobile-fu' #use mobile-fu to detect mobile devices

# SEO
gem 'friendly_id', '~> 5.0.0' #use friendly URLs with slugs
#gem "dynamic_sitemaps"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Javascript stuff
gem 'coffee-rails', '~> 4.0.0'
gem 'gon' #use gon to pass variables from Rails to front-end javascript

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks' # in theory, this lets us use $(document).ready, even though we're using turbolinks

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# ActiveRecord Plugins
gem 'devise' #for use authentification
gem 'omniauth-facebook' #for Facebook auth
gem 'fb_graph' #this is a Facebook API library written in ruby
#gem 'koala'
gem 'merit' #this lets users earn points and badges

# Geocoding
gem 'geocoder' #use geocoder for geospatial processing and mapping

# Pagination
gem 'kaminari' #pagination plugin

# Image attachments
gem "paperclip", "~> 3.0" #stores photos and files to Amazon S3 server

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0' #Devise uses this to encrypt passwords

# Use unicorn as the app server
gem 'unicorn' # The web server. It works well with Heroku.

# Use Capistrano for deployment
# gem 'capistrano', group: :development
group :production do
  gem 'rails_12factor' #Heroku's gem for Rails deployments
  gem 'pg' #Postgresql
  gem 'aws-sdk' #Assists with Amazon S3 integration
end

group :test do
  gem 'capybara' #Allows integration tests to simulate user interactions, like clicking or filling out forms
  gem 'factory_girl_rails' #Creates factories for testing
end

ruby '2.0.0'
# Use debugger
# gem 'debugger', group: [:development, :test]
