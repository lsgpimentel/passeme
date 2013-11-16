class CreateUsersViewTimetables < ActiveRecord::Migration
  def change
    drop_table :users_view_syllabuses

    create_table :users_view_timetables, id: false do |t|
      t.belongs_to :user, null: false
      t.belongs_to :timetable, null: false
    end

    add_index(:users_view_timetables, [:user_id, :timetable_id], :unique => true)
  end
end

