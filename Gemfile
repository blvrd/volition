source "https://rubygems.org"

ruby "2.4.0"

gem "autoprefixer-rails"
gem "flutie"
gem "high_voltage"
gem "jquery-rails"
gem "appsignal"
gem "sidekiq"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem 'turbolinks'
gem "puma"
gem "rails", "~> 5.1.0"
gem "recipient_interceptor"
gem "sass-rails"
gem "sprockets", ">= 3.0.0"
gem "sprockets-es6"
gem "title"
gem "uglifier"
gem "jbuilder"
gem "listen"
gem "spring"
gem 'letter_opener'
gem 'react-rails'
gem 'bcrypt'
gem 'will_paginate', '~> 3.1.0'
gem 'twilio-ruby'
gem 'premailer-rails'
gem 'rubycritic', require: false
gem 'stripe'
gem 'font-awesome-rails'
gem 'stripe_event'
gem 'gon'
gem 'redis-rails'
gem 'rack-cors', :require => 'rack/cors'
gem 'google_sign_in'
gem 'google-id-token', git: 'https://github.com/google/google-id-token.git'
gem 'enumerize'
gem "gibbon"
gem 'premailer-rails'

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "pry-byebug"
  gem "pry-rails"
end

group :development, :staging do
  gem 'rack-mini-profiler', require: false
end

group :test do
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
  gem 'minitest-reporters'
  gem 'minitest-stub_any_instance'
  gem 'climate_control'
  gem 'stripe-ruby-mock',
    git: 'https://github.com/rebelidealist/stripe-ruby-mock.git',
    branch: 'master',
    require: 'stripe_mock'
end

group :staging, :production do
  gem "rack-timeout"
  gem "rails_stdout_logging"
  gem 'rails_12factor'
end

