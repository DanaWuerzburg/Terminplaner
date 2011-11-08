class CreateTermines < ActiveRecord::Migration
  def change
    create_table :termines do |t|
      t.datetime :date
      t.string :note

      t.timestamps
    end
  end
end
