class AddWasApprovedAndWasPaidToLogin < ActiveRecord::Migration
  def change
    add_column :logins, :was_approved, :boolean
    add_column :logins, :was_paid, :boolean
  end
end
