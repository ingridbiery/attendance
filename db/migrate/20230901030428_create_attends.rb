class CreateAttends < ActiveRecord::Migration[7.0]
  def change
    create_table :attends do |t|
      t.references :meeting, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
