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

ActiveRecord::Schema.define(version: 20181007142735) do

  create_table "attractions", force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.text "description", null: false
    t.string "address", null: false
    t.float "lat"
    t.float "lng"
    t.integer "categoey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "indroduction"
    t.string "region"
    t.text "near_by"
    t.integer "reviews_count", default: 0
  end

  create_table "categories", force: :cascade do |t|
    t.string "tag_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "attractions_count", default: 0
  end

  create_table "categories_attractions", force: :cascade do |t|
    t.integer "category_id"
    t.integer "attraction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attraction_id"], name: "index_categories_attractions_on_attraction_id"
    t.index ["category_id"], name: "index_categories_attractions_on_category_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "attraction_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attraction_id", "user_id"], name: "index_comments_on_attraction_id_and_user_id"
    t.index ["attraction_id"], name: "index_comments_on_attraction_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "attraction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attraction_id", "user_id"], name: "index_likes_on_attraction_id_and_user_id"
    t.index ["attraction_id"], name: "index_likes_on_attraction_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "list_attractions", force: :cascade do |t|
    t.integer "list_id"
    t.integer "attraction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "duration"
    t.index ["attraction_id"], name: "index_list_attractions_on_attraction_id"
    t.index ["list_id"], name: "index_list_attractions_on_list_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "origin", null: false
    t.float "origin_lat"
    t.float "origin_lng"
    t.text "search_params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "content"
    t.text "images"
    t.string "suggestion"
    t.string "status", default: "pending", null: false
    t.integer "attraction_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["attraction_id", "user_id"], name: "index_reviews_on_attraction_id_and_user_id"
    t.index ["attraction_id"], name: "index_reviews_on_attraction_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "role", default: "normal", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
