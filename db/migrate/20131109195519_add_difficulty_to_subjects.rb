class AddDifficultyToSubjects < ActiveRecord::Migration
  def change
    change_table :subjects do |t|
      t.integer :difficulty, null: false
    end
  end
end
