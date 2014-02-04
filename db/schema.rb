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

ActiveRecord::Schema.define(version: 20140204150507) do

  create_table "campsites", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "org"
    t.string   "res_phone"
    t.string   "camp_phone"
    t.string   "res_url"
    t.string   "camp_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reservable"
    t.boolean  "walkin"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.integer  "state_id"
    t.integer  "city_id"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.text     "desciption"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "destinations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.float    "map_latitude"
    t.float    "map_longitude"
    t.string   "hashtag"
    t.integer  "zoom"
  end

  create_table "tribes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "vibe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
