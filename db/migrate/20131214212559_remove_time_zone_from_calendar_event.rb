class RemoveTimeZoneFromCalendarEvent < ActiveRecord::Migration
  def change
    remove_column :calendar_events, :time_zone
  end
end
