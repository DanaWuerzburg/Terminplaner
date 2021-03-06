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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120202175824) do

  create_table "appointments", :force => true do |t|
    t.datetime "start_at"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority_number"
    t.string   "group"
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "color"
    t.datetime "end_at"
    t.string   "name"
  end

  add_index "appointments", ["group_id"], :name => "index_appointments_on_group_id"
  add_index "appointments", ["user_id"], :name => "index_appointments_on_user_id"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendship_appointments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "appointment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shared_friend_id"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "colour"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "groups", ["user_id"], :name => "index_groups_on_user_id"

  create_table "password_resets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_sessions_id"
    t.text     "data"
  end

  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"
  add_index "user_sessions", ["user_sessions_id"], :name => "index_user_sessions_on_user_sessions_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",               :default => false
    t.boolean  "active",              :default => false
  end

end
