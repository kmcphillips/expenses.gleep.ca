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

ActiveRecord::Schema.define(version: 20150603133314) do

  create_table "authorized_emails", force: :cascade do |t|
    t.string   "email",        limit: 255
    t.integer  "household_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorized_emails", ["email"], name: "index_authorized_emails_on_email", using: :btree
  add_index "authorized_emails", ["household_id"], name: "index_authorized_emails_on_household_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.boolean  "income",        limit: 1,     default: false
    t.boolean  "active",        limit: 1,     default: true
    t.integer  "household_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category_type", limit: 255,   default: "non-essential"
  end

  add_index "categories", ["active"], name: "index_categories_on_active", using: :btree
  add_index "categories", ["category_type"], name: "index_categories_on_category_type", using: :btree
  add_index "categories", ["household_id"], name: "index_categories_on_household_id", using: :btree
  add_index "categories", ["income"], name: "index_categories_on_income", using: :btree
  add_index "categories", ["name"], name: "index_categories_on_name", using: :btree

  create_table "entries", force: :cascade do |t|
    t.string   "type",              limit: 255
    t.integer  "category_id",       limit: 4
    t.integer  "household_id",      limit: 4
    t.integer  "user_id",           limit: 4
    t.text     "description",       limit: 65535
    t.integer  "amount",            limit: 4
    t.date     "incurred_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "incurred_until"
    t.float    "amortized_amount",  limit: 24
    t.integer  "entry_id",          limit: 4
    t.integer  "entry_schedule_id", limit: 4
  end

  add_index "entries", ["category_id"], name: "index_entries_on_category_id", using: :btree
  add_index "entries", ["entry_id"], name: "index_entries_on_entry_id", using: :btree
  add_index "entries", ["entry_schedule_id"], name: "index_entries_on_entry_schedule_id", using: :btree
  add_index "entries", ["household_id"], name: "index_entries_on_household_id", using: :btree
  add_index "entries", ["incurred_on"], name: "index_entries_on_incurred_on", using: :btree
  add_index "entries", ["type"], name: "index_entries_on_type", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "entry_schedules", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.integer  "category_id",  limit: 4
    t.integer  "household_id", limit: 4
    t.float    "amount",       limit: 24
    t.date     "starts_on"
    t.string   "frequency",    limit: 255
    t.boolean  "active",       limit: 1,   default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entry_schedules", ["active"], name: "index_entry_schedules_on_active", using: :btree
  add_index "entry_schedules", ["category_id"], name: "index_entry_schedules_on_category_id", using: :btree
  add_index "entry_schedules", ["household_id"], name: "index_entry_schedules_on_household_id", using: :btree

  create_table "households", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "started_on"
    t.boolean  "active",     limit: 1,   default: true
  end

  create_table "login_tokens", force: :cascade do |t|
    t.string   "token",        limit: 255
    t.integer  "household_id", limit: 4
    t.integer  "user_id",      limit: 4
    t.text     "description",  limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "login_tokens", ["household_id"], name: "index_login_tokens_on_household_id", using: :btree
  add_index "login_tokens", ["token"], name: "index_login_tokens_on_token", using: :btree
  add_index "login_tokens", ["user_id"], name: "index_login_tokens_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                limit: 255, default: "", null: false
    t.string   "encrypted_password",   limit: 255, default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",        limit: 4,   default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",   limit: 255
    t.string   "last_sign_in_ip",      limit: 255
    t.string   "authentication_token", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "household_id",         limit: 4
    t.string   "name",                 limit: 255
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["household_id"], name: "index_users_on_household_id", using: :btree

end
