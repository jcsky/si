source 'https://rubygems.org'

# default
gem 'rails', '4.2.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# database
gem 'pg'

# frontend gem
gem 'meta-tags'
gem 'simple_form'
gem 'kaminari'
gem 'bootstrap-sass', '~> 3.3.6'

# backend gem
gem 'ransack'
gem 'birthday'
gem 'aasm'
gem 'phone'
gem 'bcrypt', '~> 3.1.7'
gem 'settingslogic'

# user & login provider
gem 'omniauth'
gem 'omniauth-facebook'
gem 'devise'

# admin
gem 'activeadmin', '~> 1.0.0.pre2'

group :development do
  gem 'web-console', '~> 2.0'
  gem 'annotate'
  gem 'better_errors', '~> 0.9.0'
  gem 'spring'
  gem 'letter_opener'
  gem 'powder'
  gem 'meta_request'
  # deploy to server
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'rspec-mocks'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'faker'
end

group :test do
  gem 'webmock'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :production do
  gem 'lograge', '~> 0.3.1'
end
