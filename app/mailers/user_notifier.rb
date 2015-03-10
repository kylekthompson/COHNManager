class UserNotifier < ApplicationMailer
	default to: Proc.new { User.where(admin: true).pluck(:email) },
        from: 'teambssmanager@gmail.com'
	
	def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for Team BSS Manager' )
  end

  def send_user_waiting_for_approval_email(user)
    @user = user
    mail( :subject => "#{@user.full_name} is waiting for approval!" )
  end

  def send_dues_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Friendly reminder from Team BSS' )
  end
end
