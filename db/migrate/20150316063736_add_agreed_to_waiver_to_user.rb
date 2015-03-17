class AddAgreedToWaiverToUser < ActiveRecord::Migration
  def change
    add_column :users, :agreed_to_waiver, :boolean
  end
end
