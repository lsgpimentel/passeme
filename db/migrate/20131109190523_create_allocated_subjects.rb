class CreateAllocatedSubjects < ActiveRecord::Migration
  def change
    create_table :allocated_subjects do |t|
      t.belongs_to :subject, null: false
      t.belongs_to :study_time, null: false
      t.time :from, null: false
      t.time :to, null: false
      t.integer :interval, default: 0

    end
  end
end
