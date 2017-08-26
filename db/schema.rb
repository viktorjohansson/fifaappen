# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151027213318) do

  create_table "achievements", force: true do |t|
    t.integer  "player_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "achievements", ["player_id"], name: "index_achievements_on_player_id"

  create_table "connections", force: true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "connections", ["player_id"], name: "index_connections_on_player_id"
  add_index "connections", ["team_id"], name: "index_connections_on_team_id"

  create_table "events", force: true do |t|
    t.string   "message"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "match_id"
    t.string   "table_changes"
  end

  add_index "events", ["match_id"], name: "index_events_on_match_id"

  create_table "games", force: true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["match_id"], name: "index_games_on_match_id"
  add_index "games", ["team_id"], name: "index_games_on_team_id"

  create_table "matches", force: true do |t|
    t.integer  "home"
    t.integer  "away"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bet"
  end

  create_table "participants", force: true do |t|
    t.integer  "player_id"
    t.integer  "round_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "participants", ["match_id"], name: "index_participants_on_match_id"
  add_index "participants", ["player_id"], name: "index_participants_on_player_id"
  add_index "participants", ["round_id"], name: "index_participants_on_round_id"

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "mail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "win_streak"
    t.integer  "lose_streak"
    t.integer  "tie_streak"
  end

  create_table "rounds", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "schedule"
  end

  create_table "statistic_all_times", force: true do |t|
    t.integer  "player_id"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "ties"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.integer  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "win_streak"
    t.integer  "lose_streak"
    t.integer  "tie_streak"
  end

  add_index "statistic_all_times", ["player_id"], name: "index_statistic_all_times_on_player_id"

  create_table "statistic_last_seasons", force: true do |t|
    t.integer  "player_id"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "ties"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.integer  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "win_streak"
    t.integer  "lose_streak"
    t.integer  "tie_streak"
  end

  add_index "statistic_last_seasons", ["player_id"], name: "index_statistic_last_seasons_on_player_id"

  create_table "statistic_last_times", force: true do |t|
    t.integer  "player_id"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "ties"
    t.integer  "goals_for"
    t.integer  "goals_against"
    t.integer  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "win_streak"
    t.integer  "lose_streak"
    t.integer  "tie_streak"
  end

  add_index "statistic_last_times", ["player_id"], name: "index_statistic_last_times_on_player_id"

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
