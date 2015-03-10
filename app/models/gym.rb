class Gym < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :logins, dependent: :destroy
end
