source 'https://rubygems.org'

gem 'rails', '3.2.9'
#gem 'eventmachine', '1.0.0'
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'


gem "pg", :group => :production
gem "sqlite3-ruby", :group => :development


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'devise'
gem "haml-rails", :group => :development
gem "nested_form"

gem 'bootstrap-sass'
gem "heroku"
#gem "mailcatcher"

#gem 'rb-readline'

# For testing
group :test do
  gem "shoulda-matchers"
end
group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem "shoulda-matchers"
end

gem "pry", :group => :development