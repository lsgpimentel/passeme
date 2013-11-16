class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :object, polymorphic: true
    end

    add_reference :activities, :owner, index:true
  end
end
