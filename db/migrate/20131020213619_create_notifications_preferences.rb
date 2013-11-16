class CreateNotificationsPreferences < ActiveRecord::Migration
  def change

    create_table :notifications_preferences do |t|
      t.integer  :type, null: false
      t.integer  :send_to, null: false
    end

    add_reference :notifications_preferences, :user, index: true
  end
end
