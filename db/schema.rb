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

ActiveRecord::Schema.define(version: 20170215035623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hotels", force: :cascade do |t|
    t.string "name"
    t.text   "description"
    t.index ["name"], name: "index_hotels_on_name", using: :btree
  end

  create_table "room_rates", force: :cascade do |t|
    t.integer  "price"
    t.datetime "from_date"
    t.datetime "to_date"
    t.integer  "room_type_id"
    t.integer  "hotel_id"
    t.index ["from_date"], name: "index_room_rates_on_from_date", using: :btree
    t.index ["hotel_id"], name: "index_room_rates_on_hotel_id", using: :btree
    t.index ["room_type_id"], name: "index_room_rates_on_room_type_id", using: :btree
    t.index ["to_date"], name: "index_room_rates_on_to_date", using: :btree
  end

  create_table "room_types", force: :cascade do |t|
    t.string "name"
  end

  create_table "rooms", force: :cascade do |t|
    t.string  "name"
    t.integer "hotel_id"
    t.integer "room_type_id"
    t.index ["hotel_id"], name: "index_rooms_on_hotel_id", using: :btree
    t.index ["room_type_id"], name: "index_rooms_on_room_type_id", using: :btree
  end

  add_foreign_key "room_rates", "hotels"
  add_foreign_key "room_rates", "room_types"
  add_foreign_key "rooms", "hotels"
  add_foreign_key "rooms", "room_types"
end
