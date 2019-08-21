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

ActiveRecord::Schema.define(version: 2019_08_21_054609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "associations", force: :cascade do |t|
    t.boolean "admin", default: false
    t.bigint "colony_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["colony_id"], name: "index_associations_on_colony_id"
    t.index ["user_id"], name: "index_associations_on_user_id"
  end

  create_table "cats", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "sex"
    t.integer "age"
    t.string "photo"
    t.text "health"
    t.string "microchip_id"
    t.integer "status", default: 0
    t.float "longitude"
    t.float "latitude"
    t.bigint "colony_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.index ["colony_id"], name: "index_cats_on_colony_id"
  end

  create_table "colonies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "description"
    t.float "radius"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "address"
    t.datetime "start"
    t.datetime "end"
    t.text "description"
    t.integer "phase"
    t.bigint "colony_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "longitude"
    t.float "latitude"
    t.index ["colony_id"], name: "index_events_on_colony_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_participations_on_event_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "gender"
    t.integer "age"
    t.string "phone_number"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "associations", "colonies"
  add_foreign_key "associations", "users"
  add_foreign_key "cats", "colonies"
  add_foreign_key "events", "colonies"
  add_foreign_key "participations", "events"
  add_foreign_key "participations", "users"
end
