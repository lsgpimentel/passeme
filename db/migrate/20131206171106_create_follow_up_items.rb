class CreateFollowUpItems < ActiveRecord::Migration
  def change
    create_table :follow_up_items do |t|
      t.references :calendar_event, null: false
      t.time :studied_time
      t.integer :debt_reason


      t.timestamps
    end
  end
end
