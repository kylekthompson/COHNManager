class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.references :gym, index: true
      t.references :user, index: true
      t.datetime :logged_in_at
    end
    add_foreign_key :logins, :gyms
    add_foreign_key :logins, :users
  end
end
