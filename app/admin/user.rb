ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email,
                :auto_pay, :admin, :paid_date, 
                :approved, :sessions_remaining, 
                :notifications, :cell_phone_number,
                :carrier, gym_ids: [], 
                gym_attributes: [:id, :name, :_delete]

  filter :first_name
  filter :last_name
  filter :email
  filter :sessions_remaining
  filter :gyms
  filter :auto_pay
  filter :approved
  filter :admin
  filter :paid_date

  index do
  	selectable_column
  	column "First", :first_name
    column "Last", :last_name
  	column :email
    column "Gyms" do |user|
      user.gyms.sort.map{ |g| g.name }.join(', ')
    end
    column :paid_date
    column "Sessions", :sessions_remaining
    column :auto_pay
  	column :approved
    column :admin
    actions
    #actions do |user|
      # Link to perform the member_action, "reset_password" defined below
    #  link_to("Reset Password", reset_password_admin_user_path(user))
    #end
  end

 	form do |f|
 		f.actions
    f.input :first_name
 		f.input :last_name
 		f.input :email
    f.input :cell_phone_number, as: :phone
    f.input :carrier, as: :select, collection: ["AT&T", "Verizon", "Sprint", "T-Mobile", "Virgin Mobile", "Tracfone", "Metro PCS", "Boost Mobile", "Cricket"]
    f.input :gyms, as: :check_boxes
    f.input :paid_date, as: :datepicker, datepicker_options: { min_date: "2015-01-1", max_date: "+20Y" }
    f.input :sessions_remaining
    f.input :auto_pay
    f.input :approved
 		f.input :admin
    f.input :notifications
 		f.actions
 	end

  show do
    attributes_table do
      row :full_name
      row :email
      row :cell_phone_number
      row :carrier
      row "Gyms" do |user|
        user.gyms.sort.map{ |g| g.name }.join(', ')
      end
      row :paid_date
      row :sessions_remaining
      row :auto_pay
      row :approved
      row :admin
      row :notifications
    end
  end

  member_action :reset_password do
    # Find the user in question
    user = User.find(params[:id])

    # Call the method (from Devise) which sends them a password reset email
    user.send_reset_password_instructions

    #Sign out
    sign_out current_user

    # Redirect back to the user's page with a confirmation
    redirect_to(root_path,
      notice: "Password reset email sent to #{user.email}")
  end

end
