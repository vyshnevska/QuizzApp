# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
QuizzApp::Application.initialize!

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address               => "smtp.gmail.com",
	:port                  => 587,
	:user_name             => "vyshnevska.n@gmail.com",
	:password              => 'Lake#2013',
	:authentication        => "plain",
	:enable_starttls_auto  => true
}
