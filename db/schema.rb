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

ActiveRecord::Schema.define(version: 20150319160640) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "gyms", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gyms_users", id: false, force: :cascade do |t|
    t.integer "gym_id",  null: false
    t.integer "user_id", null: false
  end

  add_index "gyms_users", ["gym_id", "user_id"], name: "index_gyms_users_on_gym_id_and_user_id", using: :btree
  add_index "gyms_users", ["user_id", "gym_id"], name: "index_gyms_users_on_user_id_and_gym_id", using: :btree

  create_table "logins", force: :cascade do |t|
    t.integer  "gym_id"
    t.integer  "user_id"
    t.datetime "logged_in_at"
    t.boolean  "was_approved"
    t.boolean  "was_paid"
    t.boolean  "was_correct_gym", default: false
  end

  add_index "logins", ["gym_id"], name: "index_logins_on_gym_id", using: :btree
  add_index "logins", ["user_id"], name: "index_logins_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false, null: false
    t.string   "full_name"
    t.date     "paid_date"
    t.integer  "sessions_remaining",     default: 0
    t.boolean  "approved",               default: false
    t.boolean  "agreed_to_waiver"
    t.boolean  "auto_pay",               default: false
    t.boolean  "notifications",          default: false
    t.string   "cell_phone_number"
    t.string   "carrier"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "logins", "gyms"
  add_foreign_key "logins", "users"
end
