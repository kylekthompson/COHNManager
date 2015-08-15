ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Users" do
          table_for User.order("created_at desc").limit(10) do
            column :full_name do |user|
              link_to user.full_name, [:admin, user]
            end
            column :email
            column :approved
          end
          strong { link_to "View All Users", admin_users_path }
        end
      end

      column do
        panel "Logins" do
          table_for Login.order("logged_in_at desc").limit(10) do
            column :full_name do |login|
              link_to login.user.full_name, [:admin, login]
            end
            column :logged_in_at
          end
          strong { link_to "View All Logins", admin_logins_path }
        end
      end
    end
  end
end
