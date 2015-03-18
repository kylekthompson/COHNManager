class AddAutoPayToUser < ActiveRecord::Migration
  def change
    add_column :users, :auto_pay, :boolean, default: false
  end
end
