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
			create_login
			if current_user.is_paid?
				paid_path

				#current_user.gyms.each do |gym|
				#	if gym.id == cookies[:gym_id]
				#		paid_path
				#	end
				#end
				#incorrectgym_path
			else
				unpaid_path
			end
		else
			create_login
			root_path
		end
	end

	private
	def create_login
		@login = Login.new
		@login.user = current_user
		@login.logged_in_at = Time.now.in_time_zone('Eastern Time (US & Canada)')
		@login.gym = Gym.find_by(id: cookies[:gym_id])
		@login.was_approved = current_user.is_approved?
		@login.was_paid = current_user.is_paid?
		@login.save!
	end
end
