class UserNotifier < ApplicationMailer
	default :from => 'teambssmanager@gmail.com'
	
	def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for Team BSS Manager' )
  end
end
