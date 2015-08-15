ActiveAdmin.register Login do

  index do
    column :user
    column "Logged In At" do |login|
      login.logged_in_at.in_time_zone('Eastern Time (US & Canada)')
    end
    column :was_approved
    column :was_paid
  end

  csv do
    column "User" do |login|
      User.find(login.user).full_name
    end
    column "Logged In At" do |login|
      login.logged_in_at.in_time_zone('Eastern Time (US & Canada)')
    end
    column :was_approved
    column :was_paid
  end

  show do
    attributes_table do
      row :user
      row "Logged In At" do |login|
        login.logged_in_at.in_time_zone('Eastern Time (US & Canada)')
      end
      row :was_approved
      row :was_paid
    end
  end
end
