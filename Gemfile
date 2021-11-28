source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 5.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-puma'
end

group :development do
  gem 'listen'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop-airbnb'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'

  # テスト用
  gem 'factory_bot_rails'
  gem 'rails-controller-testing'
  gem 'rspec-parameterized'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i(mingw mswin x64_mingw jruby)

# ログイン機能
gem 'devise'

# view装飾
gem 'bootstrap-sass', '~>3.4.1'
gem 'jquery-rails'

gem 'faker'
# ページャー
gem 'kaminari', '~> 1.2.1'

# 画像投稿
gem 'refile', require: 'refile/rails', github: 'manfe/refile'
gem 'refile-mini_magick'

# crontab管理
gem 'whenever', require: false

# カレンダー設定
gem 'fullcalendar-rails'
gem 'momentjs-rails'

# 環境変数の管理
gem 'dotenv-rails', require: 'dotenv/rails-now'

group :production do
  gem 'mysql2'
end
