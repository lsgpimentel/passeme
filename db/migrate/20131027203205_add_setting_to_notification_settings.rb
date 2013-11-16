class AddSettingToNotificationSettings < ActiveRecord::Migration
  def change
    add_reference :notification_settings, :setting,index: true
    remove_reference :notification_settings, :user, index: true
  end
end
