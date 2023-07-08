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

ActiveRecord::Schema[7.0].define(version: 2023_07_08_030206) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drummer_artists", force: :cascade do |t|
    t.bigint "drummer_id", null: false
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_drummer_artists_on_artist_id"
    t.index ["drummer_id", "artist_id"], name: "index_drummer_artists_on_drummer_id_and_artist_id", unique: true
    t.index ["drummer_id"], name: "index_drummer_artists_on_drummer_id"
  end

  create_table "drummer_genres", force: :cascade do |t|
    t.bigint "drummer_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drummer_id", "genre_id"], name: "index_drummer_genres_on_drummer_id_and_genre_id", unique: true
    t.index ["drummer_id"], name: "index_drummer_genres_on_drummer_id"
    t.index ["genre_id"], name: "index_drummer_genres_on_genre_id"
  end

  create_table "drummers", force: :cascade do |t|
    t.string "name", null: false
    t.integer "country", null: false
    t.text "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_drummers_on_name", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.bigint "drummer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drummer_id"], name: "index_songs_on_drummer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "drummer_artists", "artists"
  add_foreign_key "drummer_artists", "drummers"
  add_foreign_key "drummer_genres", "drummers"
  add_foreign_key "drummer_genres", "genres"
  add_foreign_key "songs", "drummers"
end
