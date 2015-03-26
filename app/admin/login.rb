ActiveAdmin.register Login do

  index do
    column :gym
    column :user
    column "Logged In At" do |login|
      login.logged_in_at.in_time_zone('Eastern Time (US & Canada)')
    end
    column :was_approved
    column :was_paid
    column :was_correct_gym
  end

  csv do
    column "Gym" do |login|
      Gym.find(login.gym).name
    end
    column "User" do |login|
      User.find(login.user).full_name
    end
    column "Logged In At" do |login|
      login.logged_in_at.in_time_zone('Eastern Time (US & Canada)')
    end
    column :was_approved
    column :was_paid
    column :was_correct_gym
  end
  
end
