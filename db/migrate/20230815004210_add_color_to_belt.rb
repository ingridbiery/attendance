class AddColorToBelt < ActiveRecord::Migration[7.0]
  def change
    add_column :belts, :color, :string
  end
end
