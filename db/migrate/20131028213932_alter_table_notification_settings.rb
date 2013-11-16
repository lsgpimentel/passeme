class AlterTableNotificationSettings < ActiveRecord::Migration
  def change
    add_column :notification_settings, :send_to_site, :boolean, default: false
    add_column :notification_settings, :send_to_email, :boolean, default: false
    add_column :notification_settings, :send_to_phone, :boolean, default: false
    remove_column :notification_settings, :send_to
  end
end
