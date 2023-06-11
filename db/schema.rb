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

ActiveRecord::Schema.define(version: 2022_09_04_110618) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "white_id", null: false
    t.bigint "black_id", null: false
    t.date "date", null: false
    t.bigint "opening_id"
    t.string "result", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "white_elo"
    t.integer "black_elo"
    t.integer "number_of_moves", limit: 2, null: false
    t.string "pgn", limit: 1536, null: false
    t.string "site"
    t.index ["white_id", "black_id", "opening_id", "date"], name: "index_games_on_white_id_and_black_id_and_opening_id_and_date"
  end

  create_table "moves", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "number", null: false
    t.string "move", limit: 7, null: false
    t.string "from", limit: 2, null: false
    t.string "to", limit: 2, null: false
    t.string "piece", limit: 1, null: false
    t.string "fen", null: false
    t.index ["fen"], name: "index_moves_on_fen"
    t.index ["game_id"], name: "index_moves_on_game_id"
  end

  create_table "openings", force: :cascade do |t|
    t.string "ecocode"
    t.string "name"
    t.string "variation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ecocode"], name: "index_openings_on_ecocode"
  end

  create_table "players", force: :cascade do |t|
    t.integer "fideid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name", null: false
    t.integer "white_games_count", limit: 2, default: 0, null: false
    t.integer "black_games_count", limit: 2, default: 0, null: false
    t.index ["first_name", "last_name"], name: "index_players_on_first_name_and_last_name"
  end

  add_foreign_key "games", "openings"
  add_foreign_key "games", "players", column: "black_id"
  add_foreign_key "games", "players", column: "white_id"
  add_foreign_key "moves", "games"
end
