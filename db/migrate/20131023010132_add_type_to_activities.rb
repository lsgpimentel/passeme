class AddTypeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :type, :integer, null: false
  end
end
