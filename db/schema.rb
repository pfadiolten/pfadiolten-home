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

ActiveRecord::Schema.define(version: 20180102132157) do

  create_table "albums", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "images"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "name_of_album", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title", null: false
    t.text "text", null: false
    t.string "image"
    t.boolean "is_pinned", null: false
    t.datetime "pinned_till"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "author_of_article"
  end

  create_table "documents", force: :cascade do |t|
    t.string "name", null: false
    t.string "link", null: false
    t.string "context_type", null: false
    t.integer "context_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["context_type", "context_id"], name: "context_of_document"
  end

  create_table "event_activity_details", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_camp_details", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_groups", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "group_id"], name: "unique_event_group", unique: true
    t.index ["event_id"], name: "event_of_group"
    t.index ["group_id"], name: "group_of_event"
  end

# Could not dump table "events" because of following StandardError
#   Unknown type 'long' for column 'display_days_amount'

  create_table "groups", force: :cascade do |t|
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

  create_table "members", force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "user_id", null: false
    t.integer "role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "user_id"], name: "unique_group_user_of_member", unique: true
    t.index ["group_id"], name: "group_of_member"
    t.index ["role_id"], name: "role_of_member"
    t.index ["user_id"], name: "user_of_member"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "can_edit_members", default: false, null: false
    t.boolean "can_edit_group", default: false, null: false
    t.integer "group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "group_of_role"
    t.index ["name", "group_id"], name: "unique_name_of_role", unique: true
  end

  create_table "users", force: :cascade do |t|
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

end
