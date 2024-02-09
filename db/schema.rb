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

ActiveRecord::Schema[7.1].define(version: 2024_02_09_065013) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "information"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_placements", force: :cascade do |t|
    t.string "year"
    t.integer "applied"
    t.integer "selected"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_company_placements_on_company_id"
  end

  create_table "opportunities", force: :cascade do |t|
    t.bigint "company_id"
    t.string "status"
    t.integer "no_of_applications"
    t.string "designation"
    t.string "skillset"
    t.float "package"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_opportunities_on_company_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_placements", force: :cascade do |t|
    t.bigint "company_id"
    t.string "designation"
    t.float "package"
    t.text "requirements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["company_id"], name: "index_student_placements_on_company_id"
    t.index ["user_id"], name: "index_student_placements_on_user_id"
  end

  create_table "testimonials", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_testimonials_on_user_id"
  end

  create_table "user_applications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "opportunity_id"
    t.index ["opportunity_id"], name: "index_user_applications_on_opportunity_id"
    t.index ["user_id"], name: "index_user_applications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "role_id"
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "branch"
    t.string "batch"
    t.boolean "placed"
    t.string "linkedin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "company_placements", "companies"
  add_foreign_key "opportunities", "companies"
  add_foreign_key "student_placements", "companies"
  add_foreign_key "student_placements", "users"
  add_foreign_key "testimonials", "users"
  add_foreign_key "user_applications", "opportunities"
  add_foreign_key "user_applications", "users"
  add_foreign_key "users", "roles"
end
