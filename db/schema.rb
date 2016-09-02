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

ActiveRecord::Schema.define(version: 20160902152013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", force: :cascade do |t|
    t.integer  "player_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["player_id"], name: "index_abilities_on_player_id", using: :btree
  end

  create_table "audits", force: :cascade do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "associated_id"
    t.string   "associated_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.string   "username"
    t.string   "action"
    t.text     "audited_changes"
    t.integer  "version",         default: 0
    t.string   "comment"
    t.string   "remote_address"
    t.string   "request_uuid"
    t.datetime "created_at"
    t.index ["associated_id", "associated_type"], name: "associated_index", using: :btree
    t.index ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
    t.index ["created_at"], name: "index_audits_on_created_at", using: :btree
    t.index ["request_uuid"], name: "index_audits_on_request_uuid", using: :btree
    t.index ["user_id", "user_type"], name: "user_index", using: :btree
  end

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.integer  "combat"
    t.integer  "max_grit"
    t.integer  "range_to_hit"
    t.integer  "melee_to_hit"
    t.integer  "health"
    t.integer  "defense"
    t.integer  "sanity"
    t.integer  "willpower"
    t.integer  "agility"
    t.integer  "cunning"
    t.integer  "spirit"
    t.integer  "strength"
    t.integer  "lore"
    t.integer  "luck"
    t.integer  "initiative"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "keywords"
    t.integer  "corruption",   default: 0
  end

  create_table "items", force: :cascade do |t|
    t.integer  "player_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "equipped",    default: false
    t.index ["player_id"], name: "index_items_on_player_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.integer  "character_id"
    t.integer  "starting_ability_id"
    t.string   "name"
    t.integer  "xp",                  default: 0
    t.integer  "money",               default: 0
    t.integer  "wounds",              default: 0
    t.integer  "horror_wounds",       default: 0
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "level",               default: 1
    t.integer  "darkstone",           default: 0
    t.integer  "corruption",          default: 0
    t.index ["character_id"], name: "index_players_on_character_id", using: :btree
    t.index ["starting_ability_id"], name: "index_players_on_starting_ability_id", using: :btree
  end

  create_table "stat_mods", force: :cascade do |t|
    t.string   "stat_name"
    t.integer  "amount"
    t.string   "modifiable_type"
    t.integer  "modifiable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["modifiable_type", "modifiable_id"], name: "index_stat_mods_on_modifiable_type_and_modifiable_id", using: :btree
  end

end
