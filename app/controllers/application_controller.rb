class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_admin!
  	if !current_user.try(:is_admin?)
	  	redirect_to new_user_session_path
	  	flash[:notice] = "Admin authorization required"
	  end
	end

	def after_sign_in_path_for(resource)
		if current_user.is_admin?
			if cookies[:gym_id]
				admin_root_path
			else
				setgympage_path
			end
		elsif current_user.is_approved?
			create_login
			if current_user.is_paid?
				if correct_gym?
					paid_path
				else
					incorrectgym_path
				end
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
		@login.was_correct_gym = correct_gym?
		@login.save!
	end

	def correct_gym?
    correct = false
    @gyms = current_user.gyms.all
    @gyms.each do |gym|
      if gym == Gym.find_by(id: cookies[:gym_id])
        correct = true
      end
    end
    correct
  end
end
