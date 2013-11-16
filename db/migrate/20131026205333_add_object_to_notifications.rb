class AddObjectToNotifications < ActiveRecord::Migration
  def change
    change_table :notifications do |t|
      t.references :object, polymorphic: true
      t.integer :sent_to, null: false
    end
  end

end
