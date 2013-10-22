source 'https://rubygems.org'

gem 'rails', '3.2.14'
#gem 'eventmachine', '1.0.0'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


gem "pg", :group => :production
gem 'rails_12factor', group: :production
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
gem 'omniauth'
gem 'omniauth-facebook'
gem 'oauth2'

gem "cancan"
gem 'backbone-on-rails'

gem "haml-rails"
gem "nested_form"

gem 'bootstrap-sass'
#gem "heroku"
#gem "mailcatcher"
gem 'resque', :require => "resque/server", :group => :development
gem 'aasm', '2.2.0'

# For testing
group :test do
  gem "shoulda-matchers"
end
group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem "shoulda-matchers"
end

# gem "pry", :group => :development
# gem 'rb-readline', '~> 0.4.2'
gem "pry"

#Run redis server
# redis-server /usr/local/etc/redis.conf
#Start resque queue
#rake resque:work QUEUE='*'
