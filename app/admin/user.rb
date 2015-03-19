ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email,
                :auto_pay, :admin, :paid_date, 
                :approved, :sessions_remaining, 
                :notifications, gym_ids: [], 
                gym_attributes: [:id, :name, :_delete]

  filter :first_name
  filter :last_name
  filter :email
  filter :sessions_remaining
  filter :gyms
  filter :approved
  filter :admin
  filter :paid_date

  index do
  	selectable_column
  	column :first_name
  	column :last_name
  	column :email
    column "Gyms" do |user|
      user.gyms.sort.map{ |g| g.name }.join(', ')
    end
    column :paid_date
    column :sessions_remaining
    column :auto_pay
  	column :approved
    column :admin
    #column :notifications
    actions
  end

 	form do |f|
 		f.actions
    f.input :first_name
 		f.input :last_name
 		f.input :email
    f.input :gyms, as: :check_boxes
    f.input :paid_date, as: :datepicker, datepicker_options: { min_date: "2015-01-1", max_date: "+20Y" }
    f.input :sessions_remaining
    f.input :auto_pay
    f.input :approved
 		f.input :admin
    #f.input :notifications
 		f.actions
 	end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
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

end
