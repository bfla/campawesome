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

ActiveRecord::Schema.define(version: 20140214140654) do

  create_table "been_heres", force: true do |t|
    t.integer  "campsite_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "been_heres", ["campsite_id"], name: "index_been_heres_on_campsite_id"
  add_index "been_heres", ["user_id"], name: "index_been_heres_on_user_id"

  create_table "beens", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.text     "description"
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

  create_table "listeds", force: true do |t|
    t.integer  "campsite_id"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "title"
    t.string   "license_type"
    t.text     "license_text"
    t.integer  "user_id"
    t.integer  "campsite_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "destination_id"
    t.text     "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_file_name"
    t.string   "photo_file_content_type"
    t.integer  "photo_file_file_size"
    t.datetime "photo_file_updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "ratable_id"
    t.string   "ratable_type"
    t.float    "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "hashtag"
    t.integer  "zoom"
  end

  create_table "tribal_memberships", force: true do |t|
    t.integer  "tribe_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tribes", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "vibe"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "join_pic_file_name"
    t.string   "join_pic_content_type"
    t.integer  "join_pic_file_size"
    t.datetime "join_pic_updated_at"
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

  create_table "vibes", force: true do |t|
    t.integer  "campsite_id"
    t.integer  "tribe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wants", force: true do |t|
    t.integer  "campsite_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
