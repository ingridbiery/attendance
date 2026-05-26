class AddNotNulltoMeetingDate < ActiveRecord::Migration[7.0]
  def change
    change_column_null :meetings, :date, false
  end
end
