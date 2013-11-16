class CreateStudySources < ActiveRecord::Migration
  def change
    create_table :study_sources do |t|

      t.timestamps
    end
  end
end
