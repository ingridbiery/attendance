class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.references :art, null: false, foreign_key: true
      t.text :day
      t.time :time

      t.timestamps
    end
  end
end
