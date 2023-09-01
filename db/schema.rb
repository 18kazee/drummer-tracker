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

ActiveRecord::Schema[7.0].define(version: 2023_09_01_135500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "spotify_name"
    t.string "spotify_id"
  end

  create_table "choices", force: :cascade do |t|
    t.string "content"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "post_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_comments_on_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
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
    t.string "youtube_videos", default: [], array: true
    t.string "discogs_id"
    t.string "image_urls", default: [], array: true
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "drummer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drummer_id"], name: "index_favorites_on_drummer_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_likes_on_post_id"
    t.index ["user_id", "post_id"], name: "index_likes_on_user_id_and_post_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "tweet", limit: 140, null: false
    t.bigint "user_id", null: false
    t.bigint "drummer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id"
    t.index ["drummer_id"], name: "index_posts_on_drummer_id"
    t.index ["room_id"], name: "index_posts_on_room_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recommended_drummers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "drummer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drummer_id"], name: "index_recommended_drummers_on_drummer_id"
    t.index ["user_id"], name: "index_recommended_drummers_on_user_id"
  end

  create_table "recommended_drummers_drummers", force: :cascade do |t|
    t.bigint "recommended_drummer_id", null: false
    t.bigint "drummer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drummer_id"], name: "index_recommended_drummers_drummers_on_drummer_id"
    t.index ["recommended_drummer_id"], name: "index_recommended_drummers_drummers_on_recommended_drummer_id"
  end

  create_table "rooms", force: :cascade do |t|
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

  create_table "user_answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.bigint "choice_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["choice_id"], name: "index_user_answers_on_choice_id"
    t.index ["question_id"], name: "index_user_answers_on_question_id"
    t.index ["user_id"], name: "index_user_answers_on_user_id"
  end

  create_table "user_rooms", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_user_rooms_on_room_id"
    t.index ["user_id"], name: "index_user_rooms_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "activation_state"
    t.string "activation_token"
    t.datetime "activation_token_expires_at"
    t.boolean "guest", default: false
    t.string "avatar"
    t.text "profile"
    t.string "new_email"
    t.integer "role"
    t.index ["activation_token"], name: "index_users_on_activation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "choices", "questions"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "drummer_artists", "artists"
  add_foreign_key "drummer_artists", "drummers"
  add_foreign_key "drummer_genres", "drummers"
  add_foreign_key "drummer_genres", "genres"
  add_foreign_key "favorites", "drummers"
  add_foreign_key "favorites", "users"
  add_foreign_key "likes", "posts"
  add_foreign_key "likes", "users"
  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "posts", "drummers"
  add_foreign_key "posts", "rooms"
  add_foreign_key "posts", "users"
  add_foreign_key "recommended_drummers", "drummers"
  add_foreign_key "recommended_drummers", "users"
  add_foreign_key "recommended_drummers_drummers", "drummers"
  add_foreign_key "recommended_drummers_drummers", "recommended_drummers"
  add_foreign_key "songs", "drummers"
  add_foreign_key "user_answers", "choices"
  add_foreign_key "user_answers", "questions"
  add_foreign_key "user_answers", "users"
  add_foreign_key "user_rooms", "rooms"
  add_foreign_key "user_rooms", "users"
end
