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

ActiveRecord::Schema.define(version: 20160224081246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_stats", force: :cascade do |t|
    t.integer  "group_detail_id"
    t.integer  "channel_detail_id"
    t.integer  "SKU_id",            limit: 8
    t.integer  "version"
    t.inet     "IP"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "api_stats", ["channel_detail_id"], name: "index_api_stats_on_channel_detail_id", using: :btree
  add_index "api_stats", ["group_detail_id"], name: "index_api_stats_on_group_detail_id", using: :btree

  create_table "channel_details", force: :cascade do |t|
    t.string  "channel_name"
    t.string  "channel_data_field"
    t.text    "channel_unique_key"
    t.string  "channel_code"
    t.boolean "has_product_id"
    t.boolean "has_city"
    t.text    "icon"
    t.string  "business_model"
  end

  create_table "group_details", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.jsonb    "header_json"
    t.string   "user_id"
    t.string   "secret_key"
    t.text     "authorized_urls", default: [],              array: true
    t.string   "email"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.integer  "group_detail_id"
    t.text     "channel_ids",            default: [],              array: true
    t.jsonb    "start_date"
    t.jsonb    "end_date"
    t.boolean  "opted_distributed_plan"
    t.jsonb    "max_hits_allowed"
    t.boolean  "auto_renewal"
    t.jsonb    "exhausted"
    t.jsonb    "exhausted_date"
    t.jsonb    "hits_consumed"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "subscription_plans", ["group_detail_id"], name: "index_subscription_plans_on_group_detail_id", using: :btree

  add_foreign_key "api_stats", "channel_details"
  add_foreign_key "api_stats", "group_details"
  add_foreign_key "subscription_plans", "group_details"
end
