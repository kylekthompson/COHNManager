ActiveAdmin.register Gym do
  permit_params :name, users: []

  index do
    selectable_column
    column :name
    column :users
    actions
  end

  form do |f|
    f.actions
    f.input :name
    f.inputs "Users" do
      f.input :users, as: :check_boxes, collection: User.connection.select_values(User.select("full_name").to_sql)
    end
    f.actions
  end
end
