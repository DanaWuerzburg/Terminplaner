class ChangeColourToColor < ActiveRecord::Migration
  def up
    change_table :appointments do |t|
     t.rename :colour, :color
    end
  end

  def down
    change_table :appointments do |t|
     t.rename :color, :colour
    end
  end
end
