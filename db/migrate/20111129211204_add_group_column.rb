class AddGroupColumn < ActiveRecord::Migration
  def change
    change_table :appointments do |t|
    t.string :group
end
  end
end
