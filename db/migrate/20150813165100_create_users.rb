class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :handle
      t.string :fb_username
      t.integer :fb_user_id
      t.string :fb_user_token
    end
  end
  
  def down
    drop_table :users
	end
end
