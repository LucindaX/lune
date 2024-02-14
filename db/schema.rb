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

ActiveRecord::Schema[7.1].define(version: 2024_02_14_205636) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actor_movies", force: :cascade do |t|
    t.bigint "actor_id", null: false
    t.bigint "movie_id", null: false
    t.index ["actor_id", "movie_id"], name: "index_actor_movies_on_actor_id_and_movie_id", unique: true
    t.index ["actor_id"], name: "index_actor_movies_on_actor_id"
    t.index ["movie_id"], name: "index_actor_movies_on_movie_id"
  end

  create_table "actors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_actors_on_name", unique: true
  end

  create_table "filming_locations", force: :cascade do |t|
    t.string "country"
    t.string "location"
    t.bigint "movie_id"
    t.index ["country", "location", "movie_id"], name: "index_filming_locations_on_country_and_location_and_movie_id", unique: true
    t.index ["movie_id"], name: "index_filming_locations_on_movie_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.integer "year"
    t.string "director"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_movies_on_name", unique: true
    t.index ["year"], name: "index_movies_on_year"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body"
    t.integer "stars"
    t.string "user"
    t.bigint "movies_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movies_id"], name: "index_reviews_on_movies_id"
  end

  add_foreign_key "actor_movies", "actors"
  add_foreign_key "actor_movies", "movies"
  add_foreign_key "filming_locations", "movies"
  add_foreign_key "reviews", "movies", column: "movies_id"
end
