class Login < ActiveRecord::Base
  belongs_to :gym
  belongs_to :user
end
