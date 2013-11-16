class AddColumnsToStudySources < ActiveRecord::Migration
  def change
    change_table :study_sources do |t|
      t.integer :type, null: false
      t.string :title, null: false
      t.string :author
    end
  end
end
