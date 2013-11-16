class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.datetime :created_at, null: false
      t.boolean :is_read, default: false
      t.integer :type, null: false
    end

    add_reference :notifications, :user, index: true
    add_reference :notifications, :activity, index: true

  end
end
