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

ActiveRecord::Schema.define(version: 2021_01_13_234808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

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
    t.uuid "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "author_of_article"
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
    t.text "description"
    t.index ["detail_type", "detail_id"], name: "detail_of_event"
    t.index ["user_in_charge_id"], name: "user_in_charge_of_event"
  end

  create_table "file_avatars", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "file", null: false
    t.string "avatarable_type"
    t.uuid "avatarable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avatarable_type", "avatarable_id"], name: "index_file_avatars_on_avatarable_type_and_avatarable_id"
  end

  create_table "file_images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "file", null: false
    t.string "imageable_type"
    t.uuid "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_file_images_on_imageable_type_and_imageable_id"
  end

  create_table "group_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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

  create_table "group_roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "can_edit_members", default: false, null: false
    t.boolean "can_edit_group", default: false, null: false
    t.uuid "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "group_of_role"
    t.index ["name", "group_id"], name: "unique_name_of_role", unique: true
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

  create_table "homescouting_files", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organization_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "scout_name"
    t.string "role"
    t.uuid "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_name", "last_name"], name: "full_name_of_organization_member", unique: true
    t.index ["organization_id"], name: "organization_of_organization_member"
    t.index ["scout_name"], name: "scout_name_of_organization_member", unique: true
  end

  create_table "organizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "abbreviation", null: false
    t.text "introduction", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["abbreviation"], name: "abbreviation_of_organization", unique: true
    t.index ["name"], name: "name_of_organization", unique: true
  end

  create_table "ranks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "value", null: false
    t.string "rankable_type"
    t.uuid "rankable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rankable_type", "rankable_id"], name: "index_ranks_on_rankable_type_and_rankable_id"
    t.index ["value", "rankable_id", "rankable_type"], name: "unique_rank", unique: true
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "album_archives", "albums", name: "fk_album_of_archive"
  add_foreign_key "album_images", "albums", name: "fk_album_of_image"
  add_foreign_key "articles", "users", column: "author_id", name: "fk_author_of_article"
  add_foreign_key "event_groups", "events", name: "fk_event_of_group"
  add_foreign_key "event_groups", "groups", name: "fk_group_of_event"
  add_foreign_key "events", "users", column: "user_in_charge_id", name: "fk_user_in_charge_of_event"
  add_foreign_key "group_members", "group_roles", column: "role_id", name: "fk_role_of_member"
  add_foreign_key "group_members", "groups", name: "fk_group_of_member"
  add_foreign_key "group_members", "users", name: "fk_user_of_member"
  add_foreign_key "group_roles", "groups", name: "fk_group_of_role"
  add_foreign_key "organization_members", "organizations", name: "fk_organization_of_organization_member"
end
