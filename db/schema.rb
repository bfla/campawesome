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

ActiveRecord::Schema.define(version: 20140404163815) do

  create_table "activities", force: true do |t|
    t.integer  "activity_type_id"
    t.integer  "campsite_id"
    t.integer  "user_id"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "activity_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id"

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
    t.integer  "beenable_id"
    t.string   "beenable_type"
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
    t.float    "avg_rating"
    t.integer  "city_rank"
    t.string   "slug"
  end

  add_index "campsites", ["slug"], name: "index_campsites_on_slug"

  create_table "cities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "cities", ["slug"], name: "index_cities_on_slug", unique: true

  create_table "destinations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "zoom"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "destinations", ["slug"], name: "index_destinations_on_slug", unique: true

  create_table "fees", force: true do |t|
    t.integer  "campsite_id"
    t.float    "value"
    t.string   "per"
    t.string   "unit"
    t.text     "description"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "listeds", force: true do |t|
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "listable_id"
    t.string   "listable_type"
  end

  create_table "lists", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
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

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price"
    t.integer  "points"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "ratings", force: true do |t|
    t.integer  "ratable_id"
    t.string   "ratable_type"
    t.float    "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "review_id"
  end

  create_table "reviews", force: true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "reviewable_id"
    t.string   "reviewable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
  end

  create_table "reward_orders", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sashes", force: true do |t|
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
    t.string   "abbreviation"
    t.string   "slug"
  end

  add_index "states", ["slug"], name: "index_states_on_slug", unique: true

  create_table "taggings", force: true do |t|
    t.integer  "campsite_id"
    t.integer  "tag_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.boolean  "important"
    t.boolean  "red_flag"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "license_text"
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
    t.string   "location"
    t.integer  "state_id"
    t.integer  "sash_id"
    t.integer  "level",                  default: 0
    t.integer  "coins_spent"
    t.integer  "fb_id"
    t.string   "fb_token"
    t.boolean  "likes_me"
    t.boolean  "is_admin"
    t.integer  "reviews_count",          default: 0
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
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wantable_id"
    t.string   "wantable_type"
  end

end
