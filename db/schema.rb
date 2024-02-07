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

ActiveRecord::Schema[7.1].define(version: 2024_02_06_104432) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_blogs_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.bigint "company_placements_id"
    t.string "name"
    t.string "information"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_placements_id"
    t.index ["company_placements_id"], name: "index_companies_on_company_placements_id"
    t.index ["student_placements_id"], name: "index_companies_on_student_placements_id"
  end

  create_table "company_placements", force: :cascade do |t|
    t.string "year"
    t.integer "applied"
    t.integer "selected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_placements", force: :cascade do |t|
    t.bigint "companies_id"
    t.string "first_name"
    t.string "last_name"
    t.string "branch"
    t.string "batch"
    t.string "designation"
    t.float "package"
    t.text "requirements"
    t.string "email"
    t.string "linkedin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["companies_id"], name: "index_student_placements_on_companies_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "roles_id"
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "branch"
    t.string "batch"
    t.boolean "placed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roles_id"], name: "index_users_on_roles_id"
  end

  add_foreign_key "blogs", "users"
  add_foreign_key "companies", "company_placements", column: "company_placements_id"
  add_foreign_key "companies", "student_placements", column: "student_placements_id"
  add_foreign_key "student_placements", "companies", column: "companies_id"
  add_foreign_key "users", "roles", column: "roles_id"
end
