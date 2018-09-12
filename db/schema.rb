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

ActiveRecord::Schema.define(version: 20180912154837) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_keys", force: :cascade do |t|
    t.bigint "user_id"
    t.string "token"
    t.string "auth_token"
    t.integer "access_key_status", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_access_keys_on_token", unique: true
    t.index ["user_id"], name: "index_access_keys_on_user_id"
  end

  create_table "accounts", force: :cascade do |t|
    t.string "name", null: false
    t.string "company", null: false
    t.integer "account_status", default: 0
    t.integer "account_type", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "customer_id"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "country_name"
    t.string "country_code"
    t.string "company"
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "suffix"
    t.string "phone"
    t.string "province"
    t.string "zip"
    t.boolean "default", default: false
    t.integer "address_status", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "components", force: :cascade do |t|
    t.integer "variant_id"
    t.decimal "quantity"
    t.decimal "cost"
    t.integer "status", default: 0
    t.integer "component_status", default: 0
    t.integer "component_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["variant_id"], name: "index_components_on_variant_id"
  end

  create_table "customers", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "default_address_id"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "email"
    t.string "suffix"
    t.text "note"
    t.integer "customer_type", default: 0
    t.integer "customer_status", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invoice_lines", force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "variant_id"
    t.integer "product_id"
    t.string "title"
    t.string "sku"
    t.decimal "price"
    t.decimal "compare_at_price"
    t.string "barcode"
    t.integer "invoice_line_status", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "quantity", default: "1.0"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "account_id"
    t.integer "customer_id"
    t.integer "user_id"
    t.integer "invoice_number"
    t.string "note"
    t.decimal "total_line_items_price"
    t.decimal "total_discounts"
    t.decimal "subtotal"
    t.decimal "total_price"
    t.decimal "total_tax"
    t.decimal "total_weight"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "email"
    t.string "contact_number"
    t.string "suffix"
    t.integer "fulfillment_status", default: 0
    t.integer "invoice_status", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.integer "account_id"
    t.string "title"
    t.string "vendor"
    t.string "handle"
    t.integer "product_type", default: 0
    t.integer "status", default: 0
    t.integer "product_status", default: 0
    t.integer "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.integer "account_id"
    t.string "name"
    t.string "description"
    t.integer "level", default: 5
    t.integer "role_type", default: 0
    t.integer "role_status", default: 0
    t.string "code"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "invoice_id"
    t.integer "customer_id"
    t.decimal "amount"
    t.integer "transaction_type"
    t.integer "transaction_status", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "account_id", null: false
    t.string "email", null: false
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "suffix"
    t.string "title"
    t.string "password_digest", null: false
    t.integer "user_type"
    t.integer "user_status", default: 0
    t.string "token"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "email"], name: "index_users_on_account_id_and_email", unique: true
    t.index ["account_id"], name: "index_users_on_account_id"
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  create_table "variants", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "parent_product_id"
    t.integer "parent_variant_id"
    t.string "title"
    t.string "sku"
    t.decimal "price"
    t.decimal "compare_at_price"
    t.string "barcode"
    t.integer "variant_type", default: 0
    t.integer "variant_status", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "selling_policy", default: 0
  end

end
