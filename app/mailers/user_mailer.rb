class UserMailer < ActionMailer::Base
  default from: "vyshnevska.n@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000"
    p "======================================"
    mail(:to => user.email, :subject => "Welcome to Hamster:) Web Site!")
  end

  def test_email
    @to =  'ninawish@ukr.net'
    @subject = "This is test email"
    mail(:to => @to, :subject => @subject, :message => "It should get delivered to recipient inbox")
 end

end
