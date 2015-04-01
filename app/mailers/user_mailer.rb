class UserMailer < ActionMailer::Base
  default from: "vyshnevska.n@gmail.com"
  MAIL = 'vyshnevska.n@gmail.com'

  def welcome_email(user)
    @current_user = user
    @url = 'hamster.heroku.com'
    mail(:to => @current_user.email, :subject => I18n.translate('mail.welcome'))
  end

  def finish_game game_id
    mail(:to => MAIL, :subject => I18n.translate('mail.finish_game', :game => game_id))
  end

  def start_game game_id
    mail(:to => MAIL, :subject => I18n.translate('mail.start_game', :game => game_id))
  end
end
