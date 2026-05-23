class RenameBeltFields < ActiveRecord::Migration[7.0]
  def change
    rename_column :belts, :level, :name
    rename_column :belts, :rank, :level
  end
end
