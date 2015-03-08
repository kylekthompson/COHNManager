ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email,
                :admin, :paid_date, :approved,
                :sessions_remaining, gym_ids: [],
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
      user.gyms.sort.map{ |g| g.name }.join(' ')
    end
    column :paid_date
    column :sessions_remaining
  	column :approved
    column :admin
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
    f.input :approved
 		f.input :admin
 		f.actions
 	end
end
