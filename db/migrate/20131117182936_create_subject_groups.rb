class CreateSubjectGroups < ActiveRecord::Migration
  def change
    create_table :subject_groups do |t|
      t.string :name, null: false
      t.references :user, null: false
      t.timestamps
    end
    change_table :subjects do |t|
      t.references :subject_group
    end
  end
end
