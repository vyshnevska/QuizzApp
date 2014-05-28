# class AcountsController < ApplicationController
#   def notification_flag
#     user = User.find(params[:id])
#     if user.update_attributes(:notification => params[:notification])
#       flash[:notice] = "Saved"
#     else
#       flash[:error] = "Not Saved"
#     end
#   end
#  end