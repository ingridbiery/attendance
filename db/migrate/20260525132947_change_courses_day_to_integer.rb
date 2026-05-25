class ChangeCoursesDayToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :courses, :day, :integer, using: 'day::integer'
  end
end
