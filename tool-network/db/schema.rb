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

ActiveRecord::Schema.define(version: 20180404141218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "images", force: :cascade do |t|
    t.datetime "date"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tool_id"
    t.bigint "review_id"
    t.index ["review_id"], name: "index_images_on_review_id"
    t.index ["tool_id"], name: "index_images_on_tool_id"
  end

  create_table "owner_images", force: :cascade do |t|
    t.string "file_name"
    t.integer "tool_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.datetime "date"
    t.integer "rating"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "tool_id"
    t.index ["tool_id"], name: "index_reviews_on_tool_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tools", force: :cascade do |t|
    t.string "name"
    t.boolean "on_loan"
    t.integer "condition"
    t.text "description"
    t.integer "loan_length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_tools_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "location"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "images", "reviews"
  add_foreign_key "images", "tools"
  add_foreign_key "reviews", "tools"
  add_foreign_key "reviews", "users"
  add_foreign_key "tools", "users"
end
