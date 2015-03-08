ActiveAdmin.register Gym do
  permit_params :name, user_ids: [],
                user_attributes: [:first_name,
                :last_name, :email,
                :admin, :paid_date, :approved,
                :sessions_remaining, :_delete]

  filter :users
  filter :name

  index do
    selectable_column
    column :name
    column :users
    actions
  end

  form do |f|
    f.input :name
    f.input :users, as: :check_boxes, allow_delete: true
    f.actions
  end
end
