class AddImportanceToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :importance, :integer
    Subject.update_all(importance: 3)

    change_column :subjects, :importance, :integer, null: false
  end
end
