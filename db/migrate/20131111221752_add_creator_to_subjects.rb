class AddCreatorToSubjects < ActiveRecord::Migration
  def change
    change_table :subjects do |t|
      t.references :creator, null: false
    end
  end
end
