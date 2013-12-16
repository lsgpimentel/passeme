class AddAttributesToFollowUpItem < ActiveRecord::Migration
  def change
    change_table :follow_up_items do |t|
      t.date :date, null: false
      t.time :from_time, null: false
      t.time :to_time, null: false
    end
  end
end
