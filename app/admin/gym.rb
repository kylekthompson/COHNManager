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
    column "Users" do |gym|
      gym.users.sort.map{ |u| u.full_name }.join(', ')
    end
    actions
  end

  form do |f|
    f.input :name
    f.input :users, as: :check_boxes, allow_delete: true
    f.actions
  end

  show do
    attributes_table do
      row :name
      row "Users" do |gym|
        gym.users.sort.map{ |u| u.full_name }.join(', ')
      end
    end
  end

end
