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
        panel "Gyms" do
          table_for Gym.order("created_at desc").limit(10) do
            column :name do |gym|
              link_to gym.name, [:admin, gym]
            end
          end
          strong { link_to "View All Gyms", admin_gyms_path }
        end
      end
    end
  end
end