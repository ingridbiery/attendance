class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.belongs_to :family

      t.string :first_name
      t.string :last_name
      t.date :dob

      t.timestamps
    end
  end
end
