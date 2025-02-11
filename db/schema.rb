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

ActiveRecord::Schema[8.0].define(version: 2025_02_11_214049) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorizations", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "library_resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_categorizations_on_category_id"
    t.index ["library_resource_id"], name: "index_categorizations_on_library_resource_id"
  end

  create_table "fines", force: :cascade do |t|
    t.integer "loan_id", null: false
    t.decimal "amount"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["loan_id"], name: "index_fines_on_loan_id"
  end

  create_table "library_resources", force: :cascade do |t|
    t.string "title"
    t.integer "publish_year"
    t.string "language"
    t.string "publisher"
    t.text "description"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author"
    t.integer "volume"
    t.integer "issue"
  end

  create_table "loans", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "library_resource_id", null: false
    t.datetime "loan_date"
    t.datetime "due_date"
    t.datetime "returned_at"
    t.decimal "fine"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_resource_id"], name: "index_loans_on_library_resource_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "library_resource_id", null: false
    t.datetime "reserved_at"
    t.datetime "expires_at"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["library_resource_id"], name: "index_reservations_on_library_resource_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "contact_address"
    t.string "email"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categorizations", "categories"
  add_foreign_key "categorizations", "library_resources"
  add_foreign_key "fines", "loans"
  add_foreign_key "loans", "library_resources"
  add_foreign_key "loans", "users"
  add_foreign_key "reservations", "library_resources"
  add_foreign_key "reservations", "users"
end
