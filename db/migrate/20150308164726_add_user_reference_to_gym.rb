class AddUserReferenceToGym < ActiveRecord::Migration
  def change
    add_reference :gyms, :user, index: true
    add_foreign_key :gyms, :users
  end
end
