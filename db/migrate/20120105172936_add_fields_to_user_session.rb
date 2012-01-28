class AddFieldsToUserSession < ActiveRecord::Migration
  def change
    add_column :user_sessions, :user_sessions_id, :string
    add_column :user_sessions, :data, :text

    add_index :user_sessions, :user_sessions_id
    add_index :user_sessions, :updated_at

  end


end
