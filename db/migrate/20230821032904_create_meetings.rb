class CreateMeetings < ActiveRecord::Migration[7.0]
  def change
    create_table :meetings do |t|
      t.date :date
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
