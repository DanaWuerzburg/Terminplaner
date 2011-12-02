class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login  #Username
      t.string :email
      t.string :persistence_token
      t.string :crypted_password
      t.string :password_salt
      t.string :single_access_token
      t.string :perishable_token
      t.integer :login_count
      t.integer :failed_login_count
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip

      t.timestamps
    end
  end
end
