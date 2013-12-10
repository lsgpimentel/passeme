class RemoveTitleFromCalendarEvents < ActiveRecord::Migration
  def change
    remove_column :calendar_events, :title
  end
end
