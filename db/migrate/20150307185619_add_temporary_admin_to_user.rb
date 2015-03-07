class AddTemporaryAdminToUser < ActiveRecord::Migration
  def up
    User.create! do |r|
    	r.first_name = 'Temp'
    	r.last_name  = 'User'
      r.email      = 'default@example.com'
      r.password   = 'password'
      r.admin = true
    end
  end

  def down
    User.find_by_email('default@example.com').try(:delete)
  end
end
