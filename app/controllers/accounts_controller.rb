class AccountsController < ApplicationController
  skip_before_filter :authenticate_user!
  def notification_flag
    user = User.find(params[:id])
    if user.update_attributes(:notification => params[:notification])
      if params[:notification] == "true"
        render :json => {:success => "User will get mail notifications."}
      else
        render :json => {:error => "User won't get mail notifications."}
      end
    end
  end
 end