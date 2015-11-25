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

ActiveRecord::Schema.define(version: 20151125121044) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "canceled_invitations", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.integer  "to",            null: false
    t.integer  "event_id",      null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "invitation_id"
  end

  create_table "contents", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role"
    t.integer  "content_type"
    t.string   "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "contents", ["user_id"], name: "index_contents_on_user_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "venue"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "poster_file_name"
    t.string   "poster_content_type"
    t.integer  "poster_file_size"
    t.datetime "poster_updated_at"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "to"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "accepted"
    t.boolean  "rejected"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "to"
    t.integer  "rating"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "event_id"
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "organizer"
    t.boolean  "performer"
    t.string   "location"
    t.integer  "content"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "invitations", "users"
end
