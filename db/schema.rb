# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_17_094255) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comee_core_back_order_items", force: :cascade do |t|
    t.bigint "back_order_id", null: false
    t.bigint "product_id", null: false
    t.float "requested_quantity", null: false
    t.float "requested_unit_price", null: false
    t.float "supplier_quantity", null: false
    t.float "supplier_unit_price", null: false
    t.integer "item_status", default: 0, null: false
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["back_order_id"], name: "bo_on_ccboi_indx"
    t.index ["product_id"], name: "product_on_ccboi_indx"
  end

  create_table "comee_core_back_orders", force: :cascade do |t|
    t.string "order_number", null: false
    t.date "order_date", default: -> { "CURRENT_DATE" }, null: false
    t.date "delivery_date", null: false
    t.bigint "supplier_id", null: false
    t.json "terms", default: {"freight_terms"=>"FOB", "currency"=>"EURO"}, null: false
    t.string "delivery_address", null: false
    t.string "invoice_address", null: false
    t.integer "status", default: 0, null: false
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "supplier_on_ccbo_indx"
  end

  create_table "comee_core_client_order_items", force: :cascade do |t|
    t.bigint "client_order_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_order_id"], name: "co_on_coi_indx"
    t.index ["product_id"], name: "po_on_coi_indx"
  end

  create_table "comee_core_client_orders", force: :cascade do |t|
    t.string "order_number", null: false
    t.date "order_date", default: -> { "CURRENT_DATE" }, null: false
    t.date "delivery_date", null: false
    t.bigint "client_id", null: false
    t.json "terms"
    t.integer "status", default: 0, null: false
    t.string "delivery_address", null: false
    t.string "invoice_address", null: false
    t.string "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "client_on_ccco_indx"
    t.index ["order_number"], name: "index_comee_core_client_orders_on_order_number", unique: true
  end

  create_table "comee_core_client_prices", force: :cascade do |t|
    t.date "valid_from", null: false
    t.date "valid_to", null: false
    t.float "old_price"
    t.float "new_price", null: false
    t.float "future_price"
    t.date "future_validity"
    t.bigint "product_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "client_on_cccp_indx"
    t.index ["product_id", "client_id"], name: "index_comee_core_client_prices_on_product_id_and_client_id", unique: true
    t.index ["product_id"], name: "product_on_cccp_indx"
  end

  create_table "comee_core_clients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.string "locale", default: "en", null: false
    t.string "discount", default: "0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_comee_core_clients_on_code", unique: true
    t.index ["user_id"], name: "user_on_ccc_indx"
  end

  create_table "comee_core_currencies", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_comee_core_currencies_on_code", unique: true
  end

  create_table "comee_core_master_prices", force: :cascade do |t|
    t.date "pp_valid_from", null: false
    t.date "pp_valid_to", null: false
    t.date "sp_valid_from", null: false
    t.date "sp_valid_to", null: false
    t.float "old_pprice"
    t.float "new_pprice", null: false
    t.float "old_sprice"
    t.float "new_sprice", null: false
    t.boolean "primary", null: false
    t.bigint "product_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id", "supplier_id"], name: "index_comee_core_master_prices_on_product_id_and_supplier_id", unique: true
    t.index ["product_id"], name: "product_on_ccsp_indx"
    t.index ["supplier_id"], name: "supplier_on_ccsp_indx"
  end

  create_table "comee_core_notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type"
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_comee_core_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_comee_core_notifications_on_recipient"
  end

  create_table "comee_core_order_links", force: :cascade do |t|
    t.string "link", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "client_on_ccol_indx"
  end

  create_table "comee_core_order_sources", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "client_on_ccos_indx"
  end

  create_table "comee_core_product_lookups", force: :cascade do |t|
    t.string "code", null: false
    t.string "itemable_type", null: false
    t.bigint "itemable_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["itemable_id", "itemable_type", "product_id"], name: "itemable_product_indx_uniq", unique: true
    t.index ["itemable_type", "itemable_id"], name: "index_comee_core_product_lookups_on_itemable"
    t.index ["product_id"], name: "product_on_ccep_indx"
  end

  create_table "comee_core_product_types", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.jsonb "metadata_schema", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_comee_core_product_types_on_code", unique: true
  end

  create_table "comee_core_products", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "description"
    t.jsonb "metadata"
    t.bigint "product_type_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_comee_core_products_on_code", unique: true
    t.index ["product_type_id"], name: "ccpt_on_ccp_indx"
    t.index ["unit_id"], name: "unit_on_ccp_indx"
  end

  create_table "comee_core_source_mappings", force: :cascade do |t|
    t.string "source", null: false
    t.string "destination", null: false
    t.bigint "order_source_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_source_id"], name: "order_source_on_csm_indx"
  end

  create_table "comee_core_suppliers", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.string "locale", default: "en", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_comee_core_suppliers_on_code", unique: true
    t.index ["user_id"], name: "user_on_ccs_indx"
  end

  create_table "comee_core_units", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.integer "unit_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_comee_core_units_on_code", unique: true
  end

  create_table "comee_core_users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.boolean "active", default: true, null: false
    t.string "password_digest"
    t.integer "user_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_comee_core_users_on_email", unique: true
  end

  create_table "logs", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comee_core_back_order_items", "comee_core_back_orders", column: "back_order_id"
  add_foreign_key "comee_core_back_order_items", "comee_core_products", column: "product_id"
  add_foreign_key "comee_core_back_orders", "comee_core_suppliers", column: "supplier_id"
  add_foreign_key "comee_core_client_order_items", "comee_core_client_orders", column: "client_order_id"
  add_foreign_key "comee_core_client_order_items", "comee_core_products", column: "product_id"
  add_foreign_key "comee_core_client_orders", "comee_core_clients", column: "client_id"
  add_foreign_key "comee_core_client_prices", "comee_core_clients", column: "client_id"
  add_foreign_key "comee_core_client_prices", "comee_core_products", column: "product_id"
  add_foreign_key "comee_core_clients", "comee_core_users", column: "user_id"
  add_foreign_key "comee_core_master_prices", "comee_core_products", column: "product_id"
  add_foreign_key "comee_core_master_prices", "comee_core_suppliers", column: "supplier_id"
  add_foreign_key "comee_core_order_links", "comee_core_clients", column: "client_id"
  add_foreign_key "comee_core_order_sources", "comee_core_clients", column: "client_id"
  add_foreign_key "comee_core_product_lookups", "comee_core_products", column: "product_id"
  add_foreign_key "comee_core_products", "comee_core_product_types", column: "product_type_id"
  add_foreign_key "comee_core_products", "comee_core_units", column: "unit_id"
  add_foreign_key "comee_core_source_mappings", "comee_core_order_sources", column: "order_source_id"
  add_foreign_key "comee_core_suppliers", "comee_core_users", column: "user_id"
end
