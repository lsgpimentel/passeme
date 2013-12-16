class RemoveAllocatedSubjects < ActiveRecord::Migration
  def change
    drop_table :allocated_subjects
  end
end
