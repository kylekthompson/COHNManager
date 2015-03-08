class DropTableGymsUsers < ActiveRecord::Migration
  def change
  	drop_table :gyms_users
  end
end
