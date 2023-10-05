source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"
gem "rails", "~> 7.0.7", ">= 7.0.7.2"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem "ransack"
gem 'comee_core', '0.1.9', path: 'vendor/comee_core-0.1.9.gem'
gem "httparty"
gem "active_model_serializers"
gem "savon"

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
end

group :development do
end

group :test do
  gem "simplecov"
  gem "database_cleaner-active_record"
  gem "shoulda-matchers"
end
