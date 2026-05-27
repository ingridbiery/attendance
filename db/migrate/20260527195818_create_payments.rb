class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.references :family, null: false, foreign_key: true
      t.references :art, null: false, foreign_key: true
      t.date :paid_until
      t.integer :plan_type

      t.timestamps

    end

    add_index :payments, [:family_id, :art_id], unique: true
  end
end
