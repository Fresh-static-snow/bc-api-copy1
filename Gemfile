# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'dotenv-rails', require: 'dotenv/rails-now'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'

# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'

# Use Puma as the app server
gem 'puma', '~> 4.1'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# gem 'redis-namespace'

gem 'active_storage_validations'

# gem 'aws-sdk-s3', require: false

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Blueprinter is a JSON Object Presenter for Ruby
gem 'blueprinter'

# XSS/CSRF safe JWT auth designed for SPA
gem 'devise'
gem 'devise_invitable'
gem 'devise-jwt'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'dry-configurable'

# Access rights for users
gem 'pundit'

# A PDF generation plugin for Ruby on Rails
gem 'wicked_pdf'

gem 'json', '~> 2.6'

# Simple, efficient background processing for Ruby.
gem 'sidekiq'

# Lightweight job scheduler extension for Sidekiq
gem 'sidekiq-scheduler'

gem 'sidekiq-limit_fetch'

# Add helpers to work with business days and holidays
gem 'business_time'

gem 'kaminari'

gem 'rubyzip', require: 'zip'

gem 'scenic'

gem 'whenever', require: false

gem 'validates_timeliness'

gem 'rswag'

gem 'acts_as_paranoid'

gem 'faker' # Mocking

gem "will_paginate"

gem 'google-api-client'

gem 'telegram-bot'

gem 'daemons'

gem 'discordrb'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'rspec_junit_formatter'

  gem 'timecop'

  gem 'rspec', '~> 3.10'

  # # RSpec testing framework for Rails
  # %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
  #   gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'main'
  # end

  gem 'factory_bot_rails' # Mocking for rails models
end

group :development do
  gem 'spring'

  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'brakeman', require: false # A static analysis security vulnerability scanner for Rails applications

  gem 'annotate'

  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'pry-rails'

  gem 'rails_best_practices', '~> 1.19', require: false # Code metric tool

  gem 'rubocop', require: false # Static code analyzer, based on the community Ruby style guide

  gem 'rubocop-rails'

  gem 'rubocop-rspec', require: false # Rubocop for RSpec files
end

group :test do
  # Spec helpers
  gem 'database_cleaner', '~> 1.8.2' # Strategies for cleaning databases to ensure clean state for testing suits
  gem 'shoulda-matchers', '~> 4.2.0' # Simple one-liner tests for common Rails functionality
  gem 'webmock', '~> 3.8' # Library for stubbing and setting expectations on HTTP requests

  # Code coverage
  gem 'simplecov', '~> 0.16.1', require: false # Code coverage for Ruby
  gem 'simplecov-cobertura', '~> 1.3.1' # Ruby SimpleCov Cobertura Formatter
end
