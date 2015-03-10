namespace :scheduler do
	desc "Send dues due email to users with scheduler"
	task send_dues_email: :environment do
	  puts "Sending emails..."
	  User.all.each do |user|
	  	@due_date = user.paid_date.to_date + 1.month
	  	@current_date = Date.today
	  	if (@due_date - @current_date == 5)
	  		puts("Sending to #{user.full_name}")
	  		UserNotifier.send_dues_email(user).deliver_now
	  	end
	  end
	  puts "done."
	end
end