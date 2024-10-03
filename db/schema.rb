# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_10_03_144231) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event", force: :cascade do |t|
    t.string "name"
    t.integer "capacity", default: 1
    t.bigint "organizier_id_id"
    t.index ["organizier_id_id"], name: "index_event_on_organizier_id_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "capacity", default: 1
    t.bigint "organiser_id_id"
    t.index ["organiser_id_id"], name: "index_events_on_organiser_id_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.string "email"
  end

  add_foreign_key "event", "users", column: "organizier_id_id"
  add_foreign_key "events", "users", column: "organiser_id_id"
end
