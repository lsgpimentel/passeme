class RemoveTableFollowUpItem < ActiveRecord::Migration
  def change
    change_table :calendar_events do |t|
      t.time :studied_time
      t.integer :debt_reason
    end

    drop_table :follow_up_items
  end
end
