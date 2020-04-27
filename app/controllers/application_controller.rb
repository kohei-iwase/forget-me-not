class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
 before_action :authenticate_user!
 add_flash_types :success, :danger, :info

  	protected
  		def configure_permitted_parameters
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
		end

		#サイドバー用データ
		def anniversaries
			@user.anniversaries
		end
end
