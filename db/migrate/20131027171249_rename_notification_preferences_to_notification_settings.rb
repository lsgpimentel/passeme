class RenameNotificationPreferencesToNotificationSettings < ActiveRecord::Migration
  def self.up
    rename_table :notification_preferences, :notification_settings
  end 
  def self.down
    rename_table :notification_settings, :notification_preferences
  end
end
