class CreateBelts < ActiveRecord::Migration[7.0]
  def change
    create_table :belts do |t|
      t.belongs_to :art
      t.string :level
      t.string :img
      t.integer :rank

      t.timestamps
    end
  end
end
