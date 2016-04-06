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
  enable_extension "hstore"

  create_table "amazon_sales", force: :cascade do |t|
    t.text    "sku_id",       null: false
    t.text    "description"
    t.integer "sales_volume"
    t.time    "sale_date"
  end

  create_table "api_stats", force: :cascade do |t|
    t.integer  "group_detail_id"
    t.integer  "channel_detail_id"
    t.text     "SKU_id"
    t.integer  "version"
    t.inet     "IP"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "api_stats", ["channel_detail_id"], name: "index_api_stats_on_channel_detail_id", using: :btree
  add_index "api_stats", ["group_detail_id"], name: "index_api_stats_on_group_detail_id", using: :btree

  create_table "bigbasket_sales", force: :cascade do |t|
    t.text    "sku_id",                 null: false
    t.text    "brand",                  null: false
    t.text    "description"
    t.text    "manufacturer"
    t.text    "new_department"
    t.text    "department"
    t.text    "new_top_level_category"
    t.text    "bottom_category"
    t.text    "top_level_category"
    t.time    "sale_date"
    t.text    "city",                   null: false
    t.integer "sale_qty"
    t.integer "sale_value"
  end

  create_table "brand_catg_assoc", force: :cascade do |t|
    t.integer  "brand_id",          default: "nextval('brand_catg_assoc_brand_id_seq'::regclass)",   null: false
    t.integer  "created_by",        default: "nextval('brand_catg_assoc_created_by_seq'::regclass)", null: false
    t.datetime "created_timestamp"
    t.text     "category_id"
  end

  create_table "brand_detail", force: :cascade do |t|
    t.text     "brand_name"
    t.integer  "created_by",        default: "nextval('brand_detail_created_by_seq'::regclass)", null: false
    t.datetime "created_timestamp"
  end

  add_index "brand_detail", ["brand_name"], name: "brand_name_uk", unique: true, using: :btree

  create_table "brand_sale", force: :cascade do |t|
    t.text     "brand",                      null: false
    t.decimal  "sales_qty",    default: 0.0
    t.decimal  "sales_value",  default: 0.0
    t.integer  "channel_code"
    t.text     "city"
    t.integer  "group_id"
    t.datetime "sale_date"
  end

  add_index "brand_sale", ["group_id"], name: "fki_group_detail.id", using: :btree

  create_table "category_channel_detail", primary_key: "name", force: :cascade do |t|
    t.jsonb "channel_field_json", null: false
  end

  add_index "category_channel_detail", ["channel_field_json"], name: "channel_field_json_index", using: :gin

  create_table "category_channel_export_mapping", force: :cascade do |t|
    t.integer "channel_id"
    t.jsonb   "category_list"
    t.jsonb   "mapping_json"
  end

  create_table "category_detail", force: :cascade do |t|
    t.jsonb    "category_field_json", null: false
    t.integer  "groupid"
    t.datetime "creation_time"
    t.datetime "updation_time"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "category_detail", ["category_field_json"], name: "category_field_json_index", using: :gin

  create_table "category_grp_keywords", primary_key: "keyword_id", force: :cascade do |t|
    t.text     "keyword_name"
    t.integer  "channel_id"
    t.integer  "group_id"
    t.integer  "user_id"
    t.text     "category_id"
    t.datetime "last_updated_timestamp"
    t.datetime "created_timestamp"
  end

  create_table "category_history", force: :cascade do |t|
    t.jsonb "category_json", null: false
    t.time  "timestamp",     null: false
  end

  add_index "category_history", ["category_json"], name: "category_json_index", using: :gin

  create_table "category_sale", force: :cascade do |t|
    t.text     "category_name",                           null: false
    t.datetime "sale_date",                               null: false
    t.integer  "channel_code",                            null: false
    t.integer  "group_id",                                null: false
    t.decimal  "sale_percentage", precision: 7, scale: 5
  end

  create_table "category_wise_channel_mapping", force: :cascade do |t|
    t.string "category",     limit: 150, null: false
    t.jsonb  "channel_list"
    t.jsonb  "mapping_json"
  end

  create_table "channel_detail", force: :cascade do |t|
    t.string  "channel_name",       limit: 200, null: false
    t.string  "channel_data_field", limit: 150
    t.text    "channel_unique_key"
    t.integer "channel_code"
    t.boolean "has_product_id"
    t.boolean "has_city"
    t.text    "icon"
    t.string  "business_model",     limit: 30
  end

  add_index "channel_detail", ["channel_name"], name: "channel_unique", unique: true, using: :btree

  create_table "channel_export_mapping_detail", primary_key: "channel_name", force: :cascade do |t|
    t.jsonb "channel_mapping_json", null: false
  end

  add_index "channel_export_mapping_detail", ["channel_mapping_json"], name: "channel_mapping_json_index", using: :gin

  create_table "channel_import_mapping_detail", primary_key: "channel_name", force: :cascade do |t|
    t.jsonb "import_mapping_json", null: false
  end

  add_index "channel_import_mapping_detail", ["import_mapping_json"], name: "import_mapping_json_index", using: :gin

  create_table "channel_promotions", id: false, force: :cascade do |t|
    t.integer  "id",                                default: "nextval('channel_promotions_id_seq'::regclass)",         null: false
    t.integer  "channel_id",                        default: "nextval('channel_promotions_channel_id_seq'::regclass)", null: false
    t.string   "banner_text",           limit: 150,                                                                    null: false
    t.datetime "start_date",                                                                                           null: false
    t.datetime "end_date"
    t.integer  "group_id",                          default: "nextval('channel_promotions_group_id_seq'::regclass)",   null: false
    t.jsonb    "banner_detail"
    t.integer  "created_by",                        default: "nextval('channel_promotions_created_by_seq'::regclass)", null: false
    t.datetime "created_timestamp"
    t.datetime "last_update_timestamp"
    t.integer  "updated_by"
  end

  create_table "channelfieldtype", id: false, force: :cascade do |t|
    t.string "channel_data_field", limit: 150
  end

  create_table "cities_detail", force: :cascade do |t|
    t.string "name", limit: 40
  end

  create_table "deleted_product", force: :cascade do |t|
    t.jsonb    "product_json", null: false
    t.integer  "delete_by"
    t.datetime "delete_time"
  end

  add_index "deleted_product", ["product_json"], name: "deleted_product_product_json_index", using: :gin

  create_table "group_category", force: :cascade do |t|
    t.integer "group_id",    null: false
    t.string  "category_id", null: false
  end

  create_table "group_channel", force: :cascade do |t|
    t.integer  "group_id",               default: "nextval('group_channel_group_id_seq'::regclass)",   null: false
    t.integer  "channel_id",             default: "nextval('group_channel_channel_id_seq'::regclass)", null: false
    t.boolean  "enabled"
    t.datetime "last_updated_timestamp"
    t.datetime "created_timestamp"
  end

  create_table "group_detail", force: :cascade do |t|
    t.string   "name",               limit: 50,              null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.jsonb    "header_json"
    t.jsonb    "associated_channel"
    t.string   "email"
    t.string   "user_id"
    t.string   "secret_key"
    t.text     "authorize_urls",                default: [],              array: true
  end

  create_table "image_detail", force: :cascade do |t|
    t.jsonb    "image_json",    null: false
    t.integer  "group_id",      null: false
    t.jsonb    "sku_ids_json"
    t.datetime "creation_time"
    t.datetime "updation_time"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "image_detail", ["image_json"], name: "image_json_index", using: :gin

  create_table "label_detail", force: :cascade do |t|
    t.text     "label_name"
    t.integer  "user_id",           default: "nextval('label_detail_user_id_seq'::regclass)", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_timestamp"
    t.integer  "group_id"
    t.jsonb    "search_keywords"
  end

  create_table "label_prod_assoc", force: :cascade do |t|
    t.integer  "label_id",          default: "nextval('label_prod_assoc_label_id_seq'::regclass)",    null: false
    t.integer  "user_id",           default: "nextval('label_prod_assoc_user_id_seq'::regclass)",     null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_timestamp"
    t.integer  "product_pid",       default: "nextval('label_prod_assoc_product_pid_seq'::regclass)", null: false
    t.integer  "group_id",          default: "nextval('label_prod_assoc_group_id_seq'::regclass)",    null: false
  end

  create_table "latest_operation", force: :cascade do |t|
    t.string   "action",      null: false
    t.integer  "group_id",    null: false
    t.integer  "user_id",     null: false
    t.datetime "action_time"
    t.integer  "product_id"
  end

  create_table "localbanya_sales", force: :cascade do |t|
    t.integer "product_id",  null: false
    t.text    "weight_code"
    t.text    "brand",       null: false
    t.text    "description"
    t.text    "size"
    t.integer "revenue"
    t.time    "sale_date"
  end

  create_table "peppertap_sale", force: :cascade do |t|
    t.text    "product_name"
    t.integer "qty"
    t.time    "sale_date"
    t.text    "ean",          null: false
  end

  create_table "ppimage_detailpp", id: false, force: :cascade do |t|
    t.integer "id",         default: "nextval('ppimage_detailpp_id_seq'::regclass)", null: false
    t.jsonb   "image_json",                                                          null: false
    t.integer "group_id",                                                            null: false
    t.jsonb   "sku_id",                                                              null: false
  end

  create_table "product_detail", force: :cascade do |t|
    t.jsonb    "product_json",              null: false
    t.integer  "group_id",                  null: false
    t.datetime "creation_time"
    t.datetime "updation_time"
    t.jsonb    "city_wise_mrp"
    t.string   "inserting_mode", limit: 50
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "product_detail", ["product_json"], name: "product_json_index", using: :gin

  create_table "product_detail_temp", force: :cascade do |t|
    t.jsonb    "product_json",              null: false
    t.integer  "group_id",                  null: false
    t.datetime "creation_time"
    t.datetime "updation_time"
    t.jsonb    "city_wise_mrp"
    t.string   "inserting_mode", limit: 50
  end

  add_index "product_detail_temp", ["product_json"], name: "product_json_index_temp", using: :gin

  create_table "product_history", id: false, force: :cascade do |t|
    t.integer  "id",            default: "nextval('product_history_id_seq'::regclass)", null: false
    t.jsonb    "product_json",                                                          null: false
    t.integer  "group_id",                                                              null: false
    t.datetime "updation_time"
  end

  add_index "product_history", ["product_json"], name: "deleted_product_json_index", using: :gin

  create_table "product_price_history", force: :cascade do |t|
    t.integer  "product_id",         null: false
    t.float    "last_selling_price"
    t.datetime "price_change_date"
    t.integer  "group_id"
    t.float    "last_mrp_price"
    t.integer  "changes_by"
  end

  create_table "product_sale", force: :cascade do |t|
    t.text     "sku_id",                     null: false
    t.decimal  "sales_qty",    default: 0.0
    t.decimal  "sales_value",  default: 0.0
    t.integer  "channel_code"
    t.text     "city"
    t.integer  "group_id"
    t.datetime "sale_date"
    t.text     "product_name"
    t.text     "brand_name"
  end

  create_table "role", force: :cascade do |t|
    t.string "name", limit: 50, null: false
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.integer  "group_detail_id"
    t.text     "channel_ids",            default: [],                 array: true
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "opted_distributed_plan"
    t.jsonb    "max_hits_allowed"
    t.boolean  "auto_renewal",           default: false
    t.jsonb    "exhausted"
    t.jsonb    "exhausted_date"
    t.jsonb    "hits_consumed"
    t.boolean  "active",                 default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "subscription_plans", ["group_detail_id"], name: "index_subscription_plans_on_group_detail_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.text     "tag_name",      null: false
    t.integer  "group_id"
    t.datetime "creation_time"
    t.datetime "updation_time"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "test", id: false, force: :cascade do |t|
    t.integer "id",   default: "nextval('test_id_seq'::regclass)", null: false
    t.jsonb   "name"
  end

  create_table "user_detail", force: :cascade do |t|
    t.jsonb    "user_json",     null: false
    t.datetime "updation_time"
    t.datetime "creation_time"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.text     "auth_mode"
  end

  add_index "user_detail", ["user_json"], name: "user_detail_user_json_idx", using: :gin

  create_table "video_detail", force: :cascade do |t|
    t.jsonb    "video_json",    null: false
    t.integer  "group_id",      null: false
    t.jsonb    "sku_ids_json"
    t.datetime "creation_time"
    t.datetime "updation_time"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  add_index "video_detail", ["video_json"], name: "video_json_index", using: :gin

  add_foreign_key "brand_catg_assoc", "user_detail", column: "created_by", name: "brand_catg_uid_fk"
  add_foreign_key "brand_detail", "user_detail", column: "created_by", name: "brand_uid_fk"
  add_foreign_key "brand_sale", "group_detail", column: "group_id", name: "group_detail.id"
  add_foreign_key "category_grp_keywords", "category_detail", column: "category_id", name: "cgk_cat_fk"
  add_foreign_key "category_grp_keywords", "channel_detail", column: "channel_id", name: "cgk_chnl_fk"
  add_foreign_key "category_grp_keywords", "group_detail", column: "group_id", name: "cgk_grp_fk"
  add_foreign_key "category_grp_keywords", "user_detail", column: "user_id", name: "cgk_usr_fk"
  add_foreign_key "category_sale", "group_detail", column: "group_id", name: "category_sale.group_detail.id"
  add_foreign_key "channel_promotions", "channel_detail", column: "channel_id", name: "promo_fk"
  add_foreign_key "group_channel", "channel_detail", column: "channel_id", name: "grp_chnl_cid_fk"
  add_foreign_key "group_channel", "group_detail", column: "group_id", name: "grp_chnl_gp_fk"
  add_foreign_key "label_detail", "user_detail", column: "user_id", name: "label_usr_id"
  add_foreign_key "label_prod_assoc", "label_detail", column: "label_id", name: "label_id_fk"
  add_foreign_key "label_prod_assoc", "product_detail", column: "product_pid", name: "label_prod_pid_fk"
  add_foreign_key "label_prod_assoc", "user_detail", column: "user_id", name: "lable_uid_fk"
  add_foreign_key "product_sale", "group_detail", column: "group_id", name: "product_sale.group_id"
  add_foreign_key "tags", "group_detail", column: "group_id", name: "group_id"
end
