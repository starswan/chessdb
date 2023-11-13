#
# $Id$
#
# Yet again I have no secrets from the government about which gems I'm using
source 'http://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1'
# Use mysql as the database for Active Record (Dev) - but sqlite3 for test and pi?
# Turns out sqlite doesn't really do concurrency, so have had to go back to mysql for
# now. Maybe look at pgsql?
# gem 'mysql2', platforms: :ruby
gem 'pg', platforms: :ruby
# gem 'sqlite3'
#gem 'mysql2', group: :development
#gem 'sqlite3', group: [:test, :production]
# Use SCSS for stylesheets
# gem 'sass-rails', '~> 5.0'
gem 'sassc-rails'
# Use Uglifier as compressor for JavaScript assets
# At the moment, don't compress JavaScript assets as its slow and doesn't work on the RPi2
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
#gem 'activerecord-jdbc-adapter',  platforms: :jruby
#
# bootstrap 4.x
gem "bootstrap", '~> 5.3'
gem "rails-assets-tether"

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.0',          group: :doc

# something doesn't like sprockets 4.x
gem 'sprockets', '< 4'
# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
#gem 'spring',        group: :development
# gem 'spring',        group: :test

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.19'

gem "auto_strip_attributes"
gem 'bootsnap'

# Use unicorn as the app server in production
# using mod_passenger now with Apache2
# gem 'unicorn', group: :production, platforms: :ruby
#gem 'puma', group: :production, platforms: :jruby

gem 'kaminari'
# gem 'bootstrap-sass'
# Interesting CSS toolkit Ross from MoJ showed me..https://bulma.io/alternative-to-bootstrap/
# gem 'bulma-rails'
# but apparently skeleton is popular - and there are at least 15 others
# http://senelda.com/blog/15-alternatives-bootstrap-foundation-skeleton/

# Use Capistrano for deployment
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  #gem 'byebug'

  gem 'capistrano', '~> 2.15.11'
  gem 'capistrano-ext'
  gem 'capistrano-rails'
  gem 'rvm-capistrano', require: false
  gem 'ed25519'
  gem 'bcrypt_pbkdf'

  gem 'cheat'
  gem 'listen'
  gem 'pry-rails'

  # gem "rubocop"
  gem "rubocop-govuk", "> 4"
  gem "rubocop-performance"
  gem 'rubocop-rails'
end

group :development, :test do
  gem 'rspec-rails', '< 7'
  gem 'guard'
  gem 'guard-rspec'

  gem "faraday-retry"
  gem "pronto"
  gem "pronto-rubocop"
  gem "pronto-undercover"
  gem 'capybara'
  gem "selenium-webdriver"
  gem "puma"
end

# Use debugger
# gem 'debugger', group: [:development, :test]
group :test do
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'database_cleaner'
  gem 'faker'

end
# gem 'twitter-bootstrap-rails'
gem 'rails_config'

# gem 'foundation-rails'
# PGN gem - based on Whittle, can't cope with PGN annotations
# gem 'pgn'
# 1 commit 11 years ago - sadly code doesn't seem to work (surprise!)
# There is another gem with the same name (but version 0.8.3) which seems to have less functionality
# gem 'chessmate', git: "git@github.com:mixtli/chessmate.git", require: 'chess'
# Sadly due to a lack of proper testing, this has a design flaw which makes retrieving the PGN almost
# impossible. It moves the piece, so the PGN 'moves' result ()after convert_body_to_moves) contains confused garbage
# maybe revisit if it's the best option left, but needs quite a bit of a think. Nice parser though
# gem 'treetop'
# gem 'bchess', git: 'https://github.com/PadawanBreslau/bchess'
# gem 'bchess', path: "#{ENV['HOME']}/github/bchess"
# gem "treetop"
# gem 'bchess', git: "https://github.com/starswan/bchess", branch: 'fix-pgn-bugs'
gem 'bchess'
gem 'backup-task'
gem 'chess_openings'
# successor to yaml_db - can't cope with foreign keys though, defaults to truncation
# gem 'activerecord_dumper', git: 'https://github.com/spijet/activerecord_dumper', branch: 'master', require: 'ar_dumper'

gem "backburner", "~> 1.6"
gem "addressable", "~> 2.8"
# pin psych to prevent issue when loading database.yml multi-database on ruby 3.1 and above
# gem 'psych', '< 4.0.0'
