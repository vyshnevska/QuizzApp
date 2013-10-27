source 'https://rubygems.org'

gem 'rails', '3.2.14'
#gem 'eventmachine', '1.0.0'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


gem "pg", :group => :production
gem "sqlite3", :group => :development


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
end

gem 'coffee-rails', '~> 3.2.1'
gem 'uglifier', '>= 1.0.3'
gem 'jquery-rails'

gem 'devise'
gem "cancan"
gem 'backbone-on-rails'

gem "haml-rails"
gem "nested_form"

gem 'bootstrap-sass'
#gem "heroku"
#gem "mailcatcher"
gem 'resque', :require => "resque/server"
gem 'aasm', '2.2.0'

group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem "shoulda-matchers"
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard-rspec'
  gem 'guard-livereload', require: false
end

# gem "pry", :group => :development
# gem 'rb-readline', '~> 0.4.2'
gem "pry"

#Run redis server
# redis-server /usr/local/etc/redis.conf
#Start resque queue
#rake resque:work QUEUE='*'
