require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'
require 'simplecov'

SimpleCov.start do
  # rules
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/lib/'
  add_filter '/vendor/'

  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Views', 'app/views'
end if ENV["COVERAGE"]

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"

  config.include Devise::TestHelpers, :type => :controller

  # When we want to run only specific spec
  # config.treat_symbols_as_metadata_keys_with_true_values = true
  # config.filter_run :focus => true
  # config.run_all_when_everything_filtered = true
end

end

Spork.each_run do
  # This code will be run each time you run your specs.

end
