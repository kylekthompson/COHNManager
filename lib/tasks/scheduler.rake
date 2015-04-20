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
	  puts "Done."
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
	  puts "Done."
	end

	desc "Send three days late texts"
	task send_three_days_text: :environment do
	  puts "Sending texts..."
	  User.all.each do |user|
			if user.paid_date
		  	@due_date = user.paid_date.to_date + 1.month
		  	@current_date = Date.today
		  	if ((@current_date - @due_date == 3) && (user.auto_pay? == false))
		  		User.all.each do |admin|
				    if admin.is_admin? && admin.receives_notifications? && admin.has_cell_phone_number?
				    	puts("Sending texts to #{admin.full_name}")
				    	UserNotifier.send_three_days_text(user, admin).deliver_now
				    end
				 	end
		  	end
		  end
	  end
	  puts "Done."
	end
end
