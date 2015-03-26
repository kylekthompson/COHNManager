namespace :scheduler do
	desc "Send dues due email to users with scheduler"
	task send_dues_email: :environment do
	  puts "Sending emails..."
	  User.all.each do |user|
			if user.paid_date
		  	@due_date = user.paid_date.to_date + 1.month
		  	@current_date = Date.today
		  	if ((@due_date - @current_date == 5) && (user.auto_pay? == false))
		  		puts("Sending to #{user.full_name}")
		  		UserNotifier.send_dues_email(user).deliver_now
		  	end
		  end
	  end
	  puts "done."
	end

	desc "Adjust auto pay paid date"
	task adjust_auto_paid_date: :environment do
	  puts "Adjusting dates..."
	  User.all.each do |user|
	  	if user.auto_pay?
		  	@due_date = user.paid_date.to_date + 1.month
		  	@current_date = Date.today
		  	if ((@due_date - @current_date == 0))
		  		puts("Adjusting #{user.full_name}'s paid_date")
		  		user.paid_date = @current_date
		  		user.save!
		  	end
		  end
	  end
	  puts "done."
	end
end
