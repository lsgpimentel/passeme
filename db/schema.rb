# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140331010927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "activities", force: true do |t|
    t.integer "object_id"
    t.string  "object_type"
    t.integer "owner_id"
    t.integer "type",        null: false
  end

  add_index "activities", ["owner_id"], name: "index_activities_on_owner_id", using: :btree

  create_table "calendar_event_sources", force: true do |t|
    t.integer  "subject_id",  null: false
    t.string   "color",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "calendar_id", null: false
  end

  create_table "calendar_events", force: true do |t|
    t.integer  "calendar_event_source_id",                    null: false
    t.date     "date",                                        null: false
    t.time     "from_time",                                   null: false
    t.time     "to_time",                                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "study_source_id",                             null: false
    t.string   "repeats"
    t.integer  "repeats_every_n_days"
    t.integer  "repeats_every_n_weeks"
    t.integer  "repeats_weekly_each_days_of_the_week_mask"
    t.integer  "repeats_every_n_months"
    t.string   "repeats_monthly"
    t.integer  "repeats_monthly_each_days_of_the_month_mask"
    t.integer  "repeats_monthly_on_ordinals_mask"
    t.integer  "repeats_monthly_on_days_of_the_week_mask"
    t.integer  "repeats_every_n_years"
    t.integer  "repeats_yearly_each_months_of_the_year_mask"
    t.boolean  "repeats_yearly_on"
    t.integer  "repeats_yearly_on_ordinals_mask"
    t.integer  "repeats_yearly_on_days_of_the_week_mask"
    t.string   "repeat_ends"
    t.date     "repeat_ends_on"
    t.integer  "repeat_ends_count"
    t.integer  "father_id"
    t.time     "interval"
  end

  add_index "calendar_events", ["father_id"], name: "index_calendar_events_on_father_id", using: :btree

  create_table "calendars", force: true do |t|
    t.integer  "timetable_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "follow_up_items", force: true do |t|
    t.integer  "calendar_event_id", null: false
    t.time     "studied_time"
    t.integer  "debt_reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date",              null: false
    t.time     "from_time",         null: false
    t.time     "to_time",           null: false
  end

  create_table "groups", force: true do |t|
    t.integer  "creator_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
  end

  create_table "groups_participants", id: false, force: true do |t|
    t.integer "group_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "groups_participants", ["user_id", "group_id"], name: "index_groups_participants_on_user_id_and_group_id", unique: true, using: :btree

  create_table "notification_settings", force: true do |t|
    t.integer "type",                          null: false
    t.integer "setting_id"
    t.boolean "send_to_site",  default: false
    t.boolean "send_to_email", default: false
    t.boolean "send_to_phone", default: false
  end

  add_index "notification_settings", ["setting_id"], name: "index_notification_settings_on_setting_id", using: :btree

  create_table "notifications", force: true do |t|
    t.datetime "created_at",                  null: false
    t.boolean  "is_read",     default: false
    t.integer  "type",                        null: false
    t.integer  "user_id"
    t.integer  "activity_id"
    t.integer  "object_id"
    t.string   "object_type"
    t.integer  "sent_to",                     null: false
  end

  add_index "notifications", ["activity_id"], name: "index_notifications_on_activity_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "settings", force: true do |t|
    t.integer "user_id", null: false
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id", using: :btree

  create_table "study_sources", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type",       null: false
    t.string   "title",      null: false
    t.string   "author"
    t.integer  "creator_id", null: false
  end

  create_table "study_times", force: true do |t|
    t.integer "day",          null: false
    t.time    "from",         null: false
    t.time    "to",           null: false
    t.integer "productivity", null: false
    t.integer "timetable_id", null: false
  end

  create_table "subject_groups", force: true do |t|
    t.string   "name",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subjects", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "difficulty",       null: false
    t.integer  "creator_id",       null: false
    t.string   "name",             null: false
    t.integer  "importance",       null: false
    t.integer  "subject_group_id"
  end

  create_table "subjects_study_sources", id: false, force: true do |t|
    t.integer "subject_id",      null: false
    t.integer "study_source_id", null: false
  end

  add_index "subjects_study_sources", ["subject_id", "study_source_id"], name: "index_subjects_study_sources_on_subject_id_and_study_source_id", unique: true, using: :btree

  create_table "tasks", force: true do |t|
    t.string   "name",                       null: false
    t.datetime "created_at",                 null: false
    t.boolean  "done",       default: false
    t.date     "due_in"
    t.integer  "user_id",                    null: false
  end

  add_index "tasks", ["created_at"], name: "index_tasks_on_created_at", using: :btree
  add_index "tasks", ["user_id"], name: "index_tasks_on_user_id", using: :btree

  create_table "timetables", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",         default: false
    t.boolean  "public",         default: true
    t.integer  "forked_from_id"
    t.string   "name",                           null: false
    t.string   "goal",                           null: false
    t.boolean  "specific",       default: false
    t.integer  "creator_id",                     null: false
    t.time     "block_interval",                 null: false
    t.time     "block_size",                     null: false
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale",                 default: "pt-BR"
    t.string   "name",                                     null: false
    t.string   "time_zone"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_view_timetables", id: false, force: true do |t|
    t.integer "user_id",      null: false
    t.integer "timetable_id", null: false
  end

  add_index "users_view_timetables", ["user_id", "timetable_id"], name: "index_users_view_timetables_on_user_id_and_timetable_id", unique: true, using: :btree

end
