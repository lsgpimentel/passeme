class AddTimeZoneToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :time_zone
    end
  end
end
