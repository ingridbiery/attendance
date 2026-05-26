class AddNotNullToCourseDay < ActiveRecord::Migration[7.0]
  def change
    change_column_null :courses, :day, false
  end
end
