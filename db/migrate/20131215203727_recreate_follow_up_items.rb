class RecreateFollowUpItems < ActiveRecord::Migration
  def change
    create_table :follow_up_items do |t|
      t.references :calendar_event, null: false
      t.time :studied_time
      t.integer :debt_reason

      t.timestamps
    end

    remove_column :calendar_events, :studied_time
    remove_column :calendar_events, :debt_reason
  end
end
