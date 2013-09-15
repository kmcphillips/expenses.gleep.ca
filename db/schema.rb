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

ActiveRecord::Schema.define(version: 20130914235427) do

  create_table "authorized_emails", force: true do |t|
    t.string   "email"
    t.integer  "household_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorized_emails", ["email"], name: "index_authorized_emails_on_email", using: :btree
  add_index "authorized_emails", ["household_id"], name: "index_authorized_emails_on_household_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "income",       default: false
    t.boolean  "essential",    default: false
    t.boolean  "active",       default: true
    t.integer  "household_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["active"], name: "index_categories_on_active", using: :btree
  add_index "categories", ["essential"], name: "index_categories_on_essential", using: :btree
  add_index "categories", ["household_id"], name: "index_categories_on_household_id", using: :btree
  add_index "categories", ["income"], name: "index_categories_on_income", using: :btree
  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "entries", force: true do |t|
    t.string   "type"
    t.integer  "category_id"
    t.integer  "household_id"
    t.integer  "user_id"
    t.text     "description"
    t.integer  "amount"
    t.date     "incurred_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "incurred_until"
    t.float    "amortized_amount"
    t.integer  "entry_id"
    t.integer  "entry_schedule_id"
  end

  add_index "entries", ["category_id"], name: "index_entries_on_category_id", using: :btree
  add_index "entries", ["entry_id"], name: "index_entries_on_entry_id", using: :btree
  add_index "entries", ["entry_schedule_id"], name: "index_entries_on_entry_schedule_id", using: :btree
  add_index "entries", ["household_id"], name: "index_entries_on_household_id", using: :btree
  add_index "entries", ["incurred_on"], name: "index_entries_on_incurred_on", using: :btree
  add_index "entries", ["type"], name: "index_entries_on_type", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "entry_schedules", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "household_id"
    t.float    "amount"
    t.date     "starts_on"
    t.string   "frequency"
    t.boolean  "active",       default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entry_schedules", ["active"], name: "index_entry_schedules_on_active", using: :btree
  add_index "entry_schedules", ["category_id"], name: "index_entry_schedules_on_category_id", using: :btree
  add_index "entry_schedules", ["household_id"], name: "index_entry_schedules_on_household_id", using: :btree

  create_table "households", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "started_on"
  end

  create_table "users", force: true do |t|
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["household_id"], name: "index_users_on_household_id", using: :btree

end
