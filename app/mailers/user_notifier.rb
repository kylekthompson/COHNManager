class UserNotifier < ApplicationMailer
	default to: Proc.new { User.where(admin: true).where(notifications: true).pluck(:email) },
        from: 'cohnmanager@gmail.com'

	def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for CrossFit 6817 Manager' )
  end

  def send_user_waiting_for_approval_email(user)
    @user = user
    mail( :subject => "#{@user.full_name} is waiting for approval!" )
  end

  def send_dues_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Friendly reminder from CrossFit 6817' )
  end

  def send_sessions_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Friendly reminder from CrossFit 6817' )
  end

  def send_unpaid_text(user, admin)
    @user = user
    @admin = admin
    @phone = @admin.cell_number.gsub(/[^0-9]/, "")
    @carrier = @admin.carrier
    address = nil
    case @carrier
    when "AT&T"
      address = "@txt.att.net"
    when "Verizon"
      address = "@vtext.com"
    when"Sprint"
      address = "@messaging.sprintpcs.com "
    when "T-Mobile"
      address = "@tmomail.net"
    when "Virgin Mobile"
      address = "@vmobl.com"
    when "Tracfone"
      address = "@mmst5.tracfone.com"
    when "Metro PCS"
      address = "@mymetropcs.com"
    when "Boost Mobile"
      address = "@myboostmobile.com"
    when "Cricket"
      address = "@sms.mycricket.com"
    end
    @mailto = @phone + address
    mail( :to => @mailto,
    :subject => "Member Not Paid Alert" )
  end

  def send_three_days_text(user, admin)
    @user = user
    @admin = admin
    @phone = @admin.cell_number.gsub(/[^0-9]/, "")
    @carrier = @admin.carrier
    address = nil
    case @carrier
    when "AT&T"
      address = "@txt.att.net"
    when "Verizon"
      address = "@vtext.com"
    when"Sprint"
      address = "@messaging.sprintpcs.com "
    when "T-Mobile"
      address = "@tmomail.net"
    when "Virgin Mobile"
      address = "@vmobl.com"
    when "Tracfone"
      address = "@mmst5.tracfone.com"
    when "Metro PCS"
      address = "@mymetropcs.com"
    when "Boost Mobile"
      address = "@myboostmobile.com"
    when "Cricket"
      address = "@sms.mycricket.com"
    end
    @mailto = @phone + address
    mail( :to => @mailto,
    :subject => "Three Days Late Alert" )
  end
end
