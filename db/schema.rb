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

ActiveRecord::Schema.define(version: 20180603154524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "pgcrypto"

  create_table "album_archives", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "file", null: false
    t.uuid "album_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "album_of_archive"
  end

  create_table "album_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "file", null: false
    t.uuid "album_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "album_of_image"
  end

  create_table "albums", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "name_of_album", unique: true
  end

  create_table "articles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "summary", null: false
    t.text "text", null: false
    t.string "image"
    t.boolean "is_pinned", null: false
    t.date "pinned_till"
    t.uuid "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "author_of_article"
  end

  create_table "documents", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "link", null: false
    t.string "context_type", null: false
    t.uuid "context_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_type", "context_id"], name: "context_of_document"
  end

  create_table "event_activity_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_camp_details", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "event_id", null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "group_id"], name: "unique_event_group", unique: true
    t.index ["event_id"], name: "event_of_group"
    t.index ["group_id"], name: "group_of_event"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_hidden", default: false, null: false
    t.boolean "is_private", default: false, null: false
    t.datetime "starts_at", null: false
    t.string "start_location", null: false
    t.datetime "ends_at", null: false
    t.string "end_location"
    t.integer "display_days_amount"
    t.uuid "user_in_charge_id"
    t.string "detail_type", null: false
    t.uuid "detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["detail_type", "detail_id"], name: "detail_of_event"
    t.index ["user_in_charge_id"], name: "user_in_charge_of_event"
  end

  create_table "groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation", null: false
    t.text "what"
    t.string "who"
    t.string "when"
    t.integer "index", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviation"], name: "abbreviation_of_group", unique: true
    t.index ["index"], name: "index_of_group", unique: true
    t.index ["name"], name: "name_of_group", unique: true
  end

  create_table "members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "group_id", null: false
    t.uuid "user_id", null: false
    t.uuid "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "user_id"], name: "unique_group_user_of_member", unique: true
    t.index ["group_id"], name: "group_of_member"
    t.index ["role_id"], name: "role_of_member"
    t.index ["user_id"], name: "user_of_member"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "can_edit_members", default: false, null: false
    t.boolean "can_edit_group", default: false, null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "group_of_role"
    t.index ["name", "group_id"], name: "unique_name_of_role", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "scout_name", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.text "description"
    t.string "encrypted_password", null: false
    t.boolean "is_admin", default: false, null: false
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reset_password_token"], name: "reset_password_token_of_user", unique: true
    t.index ["scout_name"], name: "scout_name_of_user", unique: true
  end

  add_foreign_key "album_archives", "albums", name: "fk_album_of_archive"
  add_foreign_key "album_images", "albums", name: "fk_album_of_image"
  add_foreign_key "articles", "users", column: "author_id", name: "fk_author_of_article"
  add_foreign_key "event_groups", "events", name: "fk_event_of_group"
  add_foreign_key "event_groups", "groups", name: "fk_group_of_event"
  add_foreign_key "events", "users", column: "user_in_charge_id", name: "fk_user_in_charge_of_event"
  add_foreign_key "members", "groups", name: "fk_group_of_member"
  add_foreign_key "members", "roles", name: "fk_role_of_member"
  add_foreign_key "members", "users", name: "fk_user_of_member"
  add_foreign_key "roles", "groups", name: "fk_group_of_role"
end
