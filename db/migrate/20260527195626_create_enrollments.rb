class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :person, null: false, foreign_key: true
      t.references :art, null: false, foreign_key: true

      t.timestamps
    end

    add_index :enrollments, [:person_id, :art_id], unique: true
  end
end
