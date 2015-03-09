class AddWasCorrectGymToLogin < ActiveRecord::Migration
  def change
    add_column :logins, :was_correct_gym, :boolean
  end
end
