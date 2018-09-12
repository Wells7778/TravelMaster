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

ActiveRecord::Schema.define(version: 20180912133721) do

  create_table "attractions", force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.text "description", null: false
    t.string "address", null: false
    t.integer "lat"
    t.integer "lng"
    t.integer "categoey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "tag_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "list_attractions", force: :cascade do |t|
    t.integer "list_id"
    t.integer "attraction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "origin", null: false
    t.integer "origin_lat"
    t.integer "origin_lng"
    t.text "respond_list"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
