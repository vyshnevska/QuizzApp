# Load the rails application
require File.expand_path('../application', __FILE__)
QuizzApp::Application.configure do
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address              => "smtp.gmail.com",
      :port                 => 587,
      :domain               => 'baci.lindsaar.net',
      :user_name            => '<username>',
      :password             => '<password>',
      :authentication       => 'plain',
      :enable_starttls_auto => true  }

end
# Initialize the rails application
QuizzApp::Application.initialize!
