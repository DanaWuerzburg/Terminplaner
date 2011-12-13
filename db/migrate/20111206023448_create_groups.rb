class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :id
      t.string :description
      t.string :colour

      t.timestamps
    end
  end
end
