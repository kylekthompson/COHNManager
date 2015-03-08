class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
	  redirect_to new_user_session_path unless current_user.try(:is_admin?)
	end

	def after_sign_in_path_for(resource)
		if current_user.is_admin?
			admin_root_path
		elsif current_user.is_approved?
			if current_user.is_paid?
				paid_path
			else
				unpaid_path
			end
		else
			root_path
		end
	end
end
