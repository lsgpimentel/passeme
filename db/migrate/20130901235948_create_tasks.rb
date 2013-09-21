class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.datetime :created_at, null: false
      t.boolean :done
      t.date :due_in
    end

    add_reference :tasks, :user, index: true
    add_index :tasks, :created_at
  end
end
