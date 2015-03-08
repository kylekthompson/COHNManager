ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :admin, :paid_date, :approved, :sessions_remaining, gyms: []

  index do
  	selectable_column
  	column :first_name
  	column :last_name
  	column :email
  	column :admin
    column :approved
    column :paid_date
    column :sessions_remaining
  	column :gyms
  	actions
  end

 	form do |f|
 		f.actions
    f.input :first_name
 		f.input :last_name
 		f.input :email
    f.input :approved
    f.input :paid_date, as: :datepicker, datepicker_options: { min_date: "2015-01-1", max_date: "+20Y" }
    f.input :sessions_remaining
 		f.inputs "Gyms" do
      f.input :gyms, as: :check_boxes, collection: Gym.all
    end
 		f.input :admin
 		f.actions
 	end
end
