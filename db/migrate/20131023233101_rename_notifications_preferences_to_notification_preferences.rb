class RenameNotificationsPreferencesToNotificationPreferences < ActiveRecord::Migration
  def self.up
    rename_table :notifications_preferences, :notification_preferences
  end 
  def self.down
    rename_table :notification_preferences, :notifications_preferences
  end
end
