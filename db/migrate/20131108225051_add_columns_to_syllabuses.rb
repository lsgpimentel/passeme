class AddColumnsToSyllabuses < ActiveRecord::Migration
  def change
    change_table :syllabuses do |t|
      t.string :name, null: false
      t.string :goal, null: false
      t.boolean :specific, default: false

      t.references :creator, null: false
    end
  end
end
