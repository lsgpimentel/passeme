class AddMakeTourOnLoginToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :make_tour_on_login, :boolean, null: false, default: true
  end
end
