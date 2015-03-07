class CreateJoinTableGymUser < ActiveRecord::Migration
  def change
    create_join_table :gyms, :users do |t|
    	t.references :gym
    	t.references :user

      t.index [:gym_id, :user_id]
      t.index [:user_id, :gym_id]
    end
  end
end
