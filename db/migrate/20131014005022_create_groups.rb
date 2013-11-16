class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.belongs_to :creator
      t.string :name, null: false
      t.datetime :created_at, null: false
    end
  end
end
