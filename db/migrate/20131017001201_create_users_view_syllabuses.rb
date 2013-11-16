class CreateUsersViewSyllabuses < ActiveRecord::Migration
  def change
    create_table :users_view_syllabuses, id: false do |t|
      t.references :syllabus, null: false
      t.references :user, null: false

    end
    add_index(:users_view_syllabuses, [:user_id, :syllabus_id], :unique => true)
  end
end
