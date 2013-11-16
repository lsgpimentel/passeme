class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.references :user, null: false, index: true
    end
  end
end
