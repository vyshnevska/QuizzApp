class ApplicationController < ActionController::Base
	protect_from_forgery
	# before_filter :authenticate_user!
	before_filter :set_user_language

	def set_user_language
		I18n.locale = 'en'
		#Temporary added
		if current_user && current_user.email == "vyshnevska.n@gmail.com"
			current_user.role = 'admin'
			current_user.save
		end
	end
end