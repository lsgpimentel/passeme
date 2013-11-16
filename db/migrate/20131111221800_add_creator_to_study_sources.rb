class AddCreatorToStudySources < ActiveRecord::Migration
  def change
    change_table :study_sources do |t|
      t.references :creator, null: false
    end
  end
end
