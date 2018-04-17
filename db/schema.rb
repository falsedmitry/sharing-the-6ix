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

ActiveRecord::Schema.define(version: 20180417194249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categorizations", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "tool_id", null: false
  end

  create_table "chats", force: :cascade do |t|
    t.text "content"
    t.boolean "unread"
    t.boolean "owner_reply"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tool_id"
    t.bigint "user_id"
    t.index ["tool_id"], name: "index_chats_on_tool_id"
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "loans", force: :cascade do |t|
    t.date "due_date"
    t.date "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "tool_id"
    t.bigint "user_id"
    t.boolean "active"
    t.index ["tool_id"], name: "index_loans_on_tool_id"
    t.index ["user_id"], name: "index_loans_on_user_id"
  end

  create_table "neighbourhoods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nbhd_image"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "review_id"
    t.index ["review_id"], name: "index_ratings_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "tool_id"
    t.json "images"
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
    t.json "owner_pictures"
    t.index ["user_id"], name: "index_tools_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "postal_code"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "neighbourhood_id"
    t.string "avatar"
    t.index ["neighbourhood_id"], name: "index_users_on_neighbourhood_id"
  end

  add_foreign_key "chats", "tools"
  add_foreign_key "chats", "users"
  add_foreign_key "loans", "tools"
  add_foreign_key "loans", "users"
  add_foreign_key "ratings", "reviews"
  add_foreign_key "reviews", "tools"
  add_foreign_key "reviews", "users"
  add_foreign_key "tools", "users"
  add_foreign_key "users", "neighbourhoods"
end
