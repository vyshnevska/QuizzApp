source 'https://rubygems.org'

gem 'rails', '3.2.14'
#gem 'eventmachine', '1.0.0'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :production do
  gem "pg"
  gem 'rails_12factor'
end

group :development do
  gem "sqlite3"
  gem 'resque', :require => "resque/server"
end


gem 'sass-rails',   '~> 3.2.3'
gem 'coffee-rails', '~> 3.2.1'
gem 'uglifier', '>= 1.0.3'
gem 'jquery-rails'
gem 'quiet_assets'

gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'oauth2'

gem 'faye'
gem 'thin'
gem 'foreman', '0.24.0'

gem "cancan"

gem "haml-rails"
gem "nested_form"

gem 'bootstrap-sass'

gem 'aasm', '2.2.0'
gem 'kaminari'

group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem "rspec-mocks"
  gem "shoulda-matchers"
  gem 'guard-rspec'
  gem 'guard-livereload', require: false
  gem "spork", "> 0.9.0.rc"
  gem "guard-spork"
  gem "database_cleaner"
  gem 'simplecov', :require => false
end

gem "pry"

# coverege
gem 'metric_fu'
gem 'rails_best_practices'
