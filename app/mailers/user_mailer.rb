class UserMailer < ActionMailer::Base
  default from: "vyshnevska.n@gmail.com"
  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000"
    binding.pry
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
  def test_email
    @to =  'ninawish@ukr.net'
    @subject = "This is test email"
    mail(:to => @to, :subject => @subject, :message => "It should get delivered to recipient inbox")
 end
end
