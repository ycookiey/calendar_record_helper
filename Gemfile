source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.3.3"
gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem "sprockets-rails"
gem "puma", "~> 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis", "~> 4.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

gem 'google-api-client', '~> 0.53.0'
gem 'googleauth'

gem 'omniauth', '~> 2.0'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

gem 'dotenv-rails'

gem 'sqlite3', '~> 1.4'

gem 'importmap-rails'

gem 'activerecord', '~> 7.0.0'

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
