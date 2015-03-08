class AdminMailer < ApplicationMailer
	default from: "notifications@teambssmanager.com"

	def new_user_waiting_for_approval(user)
    @user = user
    @admin_url = admin_root_path
    mail(to: @user.email, subject: "#{@user.full_name} is waiting for approval")
  end
end
