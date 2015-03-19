class AddCellPhoneNumberAndCarrierToUser < ActiveRecord::Migration
  def change
    add_column :users, :cell_phone_number, :string
    add_column :users, :carrier, :string
  end
end
