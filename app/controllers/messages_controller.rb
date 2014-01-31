class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @message = Message.create!(:content => params[:message][:content], :user_id => current_user.id)
  end

end
