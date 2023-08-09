class CreateArts < ActiveRecord::Migration[7.0]
  def change
    create_table :arts do |t|
      t.string :name
      t.string :abbrev

      t.timestamps
    end
  end
end