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

ActiveRecord::Schema.define(version: 2018_06_30_121321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "code_uploads", force: :cascade do |t|
    t.integer "player_id"
    t.text "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "frames", force: :cascade do |t|
    t.integer "game_id"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "external_id"
    t.boolean "completed"
  end

  create_table "games_players", id: false, force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "player_id", null: false
    t.index ["game_id", "player_id"], name: "index_games_players_on_game_id_and_player_id"
    t.index ["player_id", "game_id"], name: "index_games_players_on_player_id_and_game_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
