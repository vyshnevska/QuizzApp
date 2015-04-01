# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  config.mailer_sender = "devise@example.com"
  config.secret_key = '4b4d5ac57c6e68cf9768df627404168e27545c44b206973dba381225dd734bb12ddb4e87c2c650a8831f5e1ce45204ae7f7f85ed0ac336c5c3506ea9c180d96d'

  config.mailer = "Devise::Mailer"
  config.secret_key = '3b2b18da3857d7c1726e34c0a08f6ce7665e3620524561c29a1fd56a44e6e3186a3ebb076e667b154cec99be1685bbc9a342352e09a5e0505756858629b92636'

  require 'devise/orm/active_record'
  require "omniauth-facebook"

  config.omniauth :facebook, '169919403205681', '1645b0e34cb329d8386d03a5caa7e644',
           :scope => 'email, offline_access', :client_options => {:ssl => {:ca_file => '/usr/lib/ssl/certs/ca-certificates.crt'}}, :display => 'popup'
  config.case_insensitive_keys = [ :email ]
  config.strip_whitespace_keys = [ :email ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.timeout_in = 30.minutes
  config.expire_auth_token_on_timeout = false
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
end
