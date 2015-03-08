ActiveAdmin.register Gym do
  permit_params :name

  index do
    selectable_column
    column :name
    column :users
    actions
  end

  form do |f|
    f.input :name
    f.actions
  end
end
