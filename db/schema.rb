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

ActiveRecord::Schema.define(:version => 20140114234722) do

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.integer  "pitcher_id"
    t.integer  "umpire_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.string   "gid"
    t.integer  "umpire_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "pitchers", :force => true do |t|
    t.string   "name"
    t.string   "team"
    t.integer  "pid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pitches", :force => true do |t|
    t.float    "x_location"
    t.float    "y_location"
    t.float    "sz_top"
    t.float    "sz_bottom"
    t.string   "description"
    t.boolean  "correct_call"
    t.float    "distance_missed_x",     :default => 0.0
    t.float    "distance_missed_y",     :default => 0.0
    t.float    "total_distance_missed", :default => 0.0
    t.integer  "pid"
    t.integer  "sv_id"
    t.integer  "pitcher_id"
    t.integer  "umpire_id"
    t.integer  "batter_id"
    t.string   "type"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "abbreviation"
    t.string   "city"
    t.string   "name"
    t.string   "league"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "umpires", :force => true do |t|
    t.string   "name"
    t.string   "umpire_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
