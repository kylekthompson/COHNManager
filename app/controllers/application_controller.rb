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
			admin_root_path
		elsif current_user.agreed_to_waiver?
			create_login
			if current_user.is_approved?
				if current_user.is_paid_at_login?
					paid_path
				else
					User.all.each do |admin|
				    if admin.is_admin? && admin.receives_notifications? && admin.has_cell_phone_number?
				    	UserNotifier.send_unpaid_text(current_user, admin).deliver_now
				    end
				 	end
					unpaid_path
				end
			else
				root_path
			end
		elsif !current_user.agreed_to_waiver?
			sign_out current_user
			flash[:alert] = "You must accept the agreement."
			new_user_session_path
		end
	end

	private
	def create_login
		@login = Login.new
		@login.user = current_user
		@login.logged_in_at = Time.now.in_time_zone('Eastern Time (US & Canada)')
		@login.was_approved = current_user.is_approved?
		@login.was_paid = current_user.is_paid?
		@login.save!
	end
end
