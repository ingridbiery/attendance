class CreateRanks < ActiveRecord::Migration[7.0]
  def change
    create_table :ranks do |t|
      t.references :belt, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true

      t.timestamps
    end
  end
end
