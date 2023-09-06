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

ActiveRecord::Schema[7.0].define(version: 2023_09_05_222458) do
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

  create_table "comee_core_client_order_links", force: :cascade do |t|
    t.string "link", null: false
    t.boolean "processed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "product_id", null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "client_on_cccp_indx"
    t.index ["product_id"], name: "product_on_cccp_indx"
  end

  create_table "comee_core_clients", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.string "address", null: false
    t.string "locale", default: "en", null: false
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

  create_table "comee_core_supplier_prices", force: :cascade do |t|
    t.date "valid_from", null: false
    t.date "valid_to", null: false
    t.float "old_price"
    t.float "new_price", null: false
    t.bigint "product_id", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "product_on_ccsp_indx"
    t.index ["supplier_id"], name: "supplier_on_ccsp_indx"
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

  create_table "customer_price_lists", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_customer_price_lists_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "item_number", null: false
    t.string "item_description", null: false
    t.integer "quantity", null: false
    t.string "unit_of_measure", null: false
    t.decimal "unit_price", null: false
    t.decimal "total_price", null: false
    t.date "supplier_purchase_price_valid_from", null: false
    t.date "supplier_purchase_price_valid_to", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "pricing_id"
    t.index ["pricing_id"], name: "index_items_on_pricing_id"
  end

  create_table "logs", force: :cascade do |t|
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "order_id", null: false
    t.integer "supplier_quantity", null: false
    t.decimal "supplier_unit_price", null: false
    t.string "status", null: false
    t.text "remark", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "order_number", null: false
    t.date "delivery_date", null: false
    t.text "terms", null: false
    t.string "delivery_address", null: false
    t.string "invoice_address", null: false
    t.string "status", null: false
    t.text "remark", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pricings", force: :cascade do |t|
    t.decimal "selling_old_price", null: false
    t.decimal "selling_new_price", null: false
    t.date "selling_old_price_valid_from", null: false
    t.date "selling_new_price_valid_to", null: false
    t.decimal "purchase_old_price", null: false
    t.decimal "purchase_new_price", null: false
    t.date "purchase_old_price_valid_from", null: false
    t.date "purchase_new_price_valid_to", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_customer_references", force: :cascade do |t|
    t.string "supplier_article_number", null: false
    t.string "customer_item_number", null: false
    t.float "price", null: false
    t.bigint "supplier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supplier_id"], name: "index_supplier_customer_references_on_supplier_id"
  end

  create_table "supplier_price_lists", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_supplier_price_lists_on_item_id"
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
  add_foreign_key "comee_core_products", "comee_core_product_types", column: "product_type_id"
  add_foreign_key "comee_core_products", "comee_core_units", column: "unit_id"
  add_foreign_key "comee_core_supplier_prices", "comee_core_products", column: "product_id"
  add_foreign_key "comee_core_supplier_prices", "comee_core_suppliers", column: "supplier_id"
  add_foreign_key "comee_core_suppliers", "comee_core_users", column: "user_id"
  add_foreign_key "customer_price_lists", "items"
  add_foreign_key "items", "pricings"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "supplier_customer_references", "comee_core_suppliers", column: "supplier_id"
  add_foreign_key "supplier_price_lists", "items"
end
