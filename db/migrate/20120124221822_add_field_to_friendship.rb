class AddFieldToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :selected, :boolean, { :default => false }
  end
end
