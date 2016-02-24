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

ActiveRecord::Schema.define(version: 20160224053310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channel_details", force: :cascade do |t|
    t.string   "channel_name"
    t.string   "channgel_data_field"
    t.text     "channel_unique_key"
    t.string   "channel_code"
    t.boolean  "has_product_id"
    t.boolean  "has_city"
    t.text     "icon"
    t.string   "business_model"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "group_authentication_details", force: :cascade do |t|
    t.string   "user_id"
    t.string   "secret_key"
    t.text     "authorized_urls",  default: [],              array: true
    t.integer  "group_detail_id"
    t.string   "email"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "max_hits_allowed", default: -1
  end

  add_index "group_authentication_details", ["group_detail_id"], name: "index_group_authentication_details_on_group_detail_id", using: :btree

  create_table "group_details", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.jsonb    "header_json"
    t.boolean  "api_subscription"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "plan_consumptions", force: :cascade do |t|
    t.integer  "subscription_plan_id"
    t.datetime "plan_end_date"
    t.integer  "hits_consumed"
    t.boolean  "exhausted"
    t.datetime "exhausted_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "plan_consumptions", ["subscription_plan_id"], name: "index_plan_consumptions_on_subscription_plan_id", using: :btree

  create_table "subscription_plans", force: :cascade do |t|
    t.integer  "group_detail_id"
    t.integer  "channel_detail_id"
    t.integer  "max_hits_allowed"
    t.boolean  "auto_renewal"
    t.datetime "start_date"
    t.integer  "duration"
    t.boolean  "active"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "subscription_plans", ["channel_detail_id"], name: "index_subscription_plans_on_channel_detail_id", using: :btree
  add_index "subscription_plans", ["group_detail_id", "channel_detail_id"], name: "subscription_plan_details", unique: true, using: :btree
  add_index "subscription_plans", ["group_detail_id"], name: "index_subscription_plans_on_group_detail_id", using: :btree

  add_foreign_key "group_authentication_details", "group_details"
  add_foreign_key "plan_consumptions", "subscription_plans"
  add_foreign_key "subscription_plans", "channel_details"
  add_foreign_key "subscription_plans", "group_details"
end
