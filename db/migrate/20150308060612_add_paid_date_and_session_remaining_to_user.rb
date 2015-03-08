class AddPaidDateAndSessionRemainingToUser < ActiveRecord::Migration
  def change
    add_column :users, :paid_date, :date
    add_column :users, :sessions_remaining, :integer, default: 0
  end
end
