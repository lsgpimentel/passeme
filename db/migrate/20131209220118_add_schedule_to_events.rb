class AddScheduleToEvents < ActiveRecord::Migration
  def change
    change_table :calendar_events do |t|
      t.string :repeats
      t.integer :repeats_every_n_days
      t.integer :repeats_every_n_weeks
      t.integer :repeats_weekly_each_days_of_the_week_mask
      t.integer :repeats_every_n_months
      t.string :repeats_monthly
      t.integer :repeats_monthly_each_days_of_the_month_mask
      t.integer :repeats_monthly_on_ordinals_mask
      t.integer :repeats_monthly_on_days_of_the_week_mask
      t.integer :repeats_every_n_years
      t.integer :repeats_yearly_each_months_of_the_year_mask
      t.boolean :repeats_yearly_on
      t.integer :repeats_yearly_on_ordinals_mask
      t.integer :repeats_yearly_on_days_of_the_week_mask
      t.string :repeat_ends
      t.date :repeat_ends_on
      t.string :time_zone
    end
    remove_column :calendar_events, :schedule
  end
end
