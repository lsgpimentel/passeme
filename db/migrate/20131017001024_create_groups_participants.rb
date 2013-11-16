class CreateGroupsParticipants < ActiveRecord::Migration
  def change
    create_table :groups_participants, id: false do |t|
      t.references :group, null: false
      t.references :user, null: false
    end

    add_index(:groups_participants, [:user_id, :group_id], :unique => true)
  end
end
