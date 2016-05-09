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

ActiveRecord::Schema.define(version: 20160507061223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "active_admin_comments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.uuid     "resource_id",   null: false
    t.string   "resource_type", null: false
    t.uuid     "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "impression_politician_jobs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "impression_id"
    t.uuid     "politician_job_id"
    t.date     "started_on"
    t.date     "ended_on"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "impression_politician_jobs", ["impression_id"], name: "index_impression_politician_jobs_on_impression_id", using: :btree
  add_index "impression_politician_jobs", ["politician_job_id"], name: "index_impression_politician_jobs_on_politician_job_id", using: :btree

  create_table "impressions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "reputation",      default: 0
    t.string   "official_name"
    t.string   "name",                        null: false
    t.text     "description"
    t.string   "impression_type"
    t.hstore   "infos"
    t.hstore   "web_pages"
    t.uuid     "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "impressions", ["impression_type"], name: "index_impressions_on_impression_type", using: :btree
  add_index "impressions", ["name"], name: "index_impressions_on_name", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "politician_jobs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "organization"
    t.string   "title"
    t.string   "electoral_region"
    t.integer  "th"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "politician_jobs", ["electoral_region"], name: "index_politician_jobs_on_electoral_region", using: :btree
  add_index "politician_jobs", ["organization"], name: "index_politician_jobs_on_organization", using: :btree
  add_index "politician_jobs", ["th"], name: "index_politician_jobs_on_th", using: :btree
  add_index "politician_jobs", ["title"], name: "index_politician_jobs_on_title", using: :btree

  create_table "taggings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "tag_id"
    t.uuid     "taggable_id"
    t.string   "taggable_type"
    t.uuid     "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "fb_uid"
    t.string   "fb_token"
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fb_uid"], name: "index_users_on_fb_uid", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.boolean  "vote",          default: false, null: false
    t.uuid     "voteable_id",                   null: false
    t.string   "voteable_type",                 null: false
    t.uuid     "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], name: "index_votes_on_voteable_id_and_voteable_type", using: :btree
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], name: "fk_one_vote_per_user_per_entity", unique: true, using: :btree
  add_index "votes", ["voter_id", "voter_type"], name: "index_votes_on_voter_id_and_voter_type", using: :btree

end
