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

  def finish_game game_id
    @mail = 'vyshnevska.n@gmail.com'
    @subject =  "This game # #{game_id} is finished!"
    mail(:to => @mail, :subject => @subject)    
  end

  def start_game game_id
    @mail = 'vyshnevska.n@gmail.com'
    @subject =  "This game # #{game_id} just started!"
    mail(:to => @mail, :subject => @subject)    
  end
end
