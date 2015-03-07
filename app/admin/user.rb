ActiveAdmin.register User do
  permit_params :first_name, :last_name, :email, :admin, gyms: []

  index do
  	selectable_column
  	column :first_name
  	column :last_name
  	column :email
  	column :admin
  	column :gyms
  	actions
  end

 	form do |f|
 		f.actions
 		f.input :first_name
 		f.input :last_name
 		f.input :email
 		f.inputs "Gyms" do
      f.input :gyms, as: :check_boxes, collection: Gym.all
    end
 		f.input :admin
 		f.actions
 	end
end
