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

ActiveRecord::Schema.define(version: 2019_07_08_080613) do

  create_table "attendances", force: :cascade do |t|
    t.integer "attendee_id"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendee_id"], name: "index_attendances_on_attendee_id"
    t.index ["event_id"], name: "index_attendances_on_event_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "bga_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_games", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "category_id", null: false
    t.index ["category_id"], name: "index_categories_games_on_category_id"
    t.index ["game_id"], name: "index_categories_games_on_game_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "author_id"
    t.string "commentable_type", default: "Comment"
    t.integer "commentable_id"
    t.string "comment_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_comments_on_author_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  end

  create_table "eventgames", force: :cascade do |t|
    t.integer "attendance_id"
    t.integer "gamepiece_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_id"], name: "index_eventgames_on_attendance_id"
    t.index ["gamepiece_id"], name: "index_eventgames_on_gamepiece_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "organiser_id"
    t.string "title"
    t.string "location"
    t.boolean "is_cancelled", default: false
    t.integer "capacity", default: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_date_time"
    t.datetime "start_date_time"
    t.index ["organiser_id"], name: "index_events_on_organiser_id"
  end

  create_table "gamepieces", force: :cascade do |t|
    t.integer "owner_id"
    t.integer "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_gamepieces_on_game_id"
    t.index ["owner_id"], name: "index_gamepieces_on_owner_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "bga_id"
    t.string "name"
    t.text "description"
    t.string "publisher"
    t.integer "year_published"
    t.integer "min_players"
    t.integer "max_players"
    t.integer "min_playtime"
    t.integer "max_playtime"
    t.integer "min_age"
    t.float "average_user_rating"
    t.string "image_thumb"
    t.string "image_small"
    t.string "image_medium"
    t.string "image_large"
    t.string "image_original"
    t.string "rules_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games_mechanics", id: false, force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "mechanic_id", null: false
    t.index ["game_id"], name: "index_games_mechanics_on_game_id"
    t.index ["mechanic_id"], name: "index_games_mechanics_on_mechanic_id"
  end

  create_table "mechanics", force: :cascade do |t|
    t.string "bga_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.date "member_since"
  end

end
