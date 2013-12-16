class AddRepeatEndsCountToCalendarEvents < ActiveRecord::Migration
  def change
    add_column :calendar_events, :repeat_ends_count, :integer
  end
end
