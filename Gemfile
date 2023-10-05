# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'
gem 'active_model_serializers'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'comee_core', '~> 0.1.9'
gem 'httparty'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.7', '>= 7.0.7.2'
gem 'ransack'
gem 'savon'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
end

group :development do
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
