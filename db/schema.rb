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

ActiveRecord::Schema.define(version: 20140812185930) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analytics", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "announcements", force: true do |t|
    t.integer  "campaign_id"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "campaigns", force: true do |t|
    t.string   "hashtag"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "initial_tweet_id"
    t.integer  "user_id"
    t.boolean  "completed"
    t.boolean  "tweet_at_creation"
    t.integer  "max_entries"
  end

  create_table "prizes", force: true do |t|
    t.integer  "campaign_id"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  create_table "tweets", force: true do |t|
    t.string   "text"
    t.string   "screen_name"
    t.datetime "entry_time"
    t.integer  "followers_count"
    t.integer  "status_id",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
    t.string   "name"
    t.string   "tweet_hour"
    t.boolean  "valid_entry"
    t.integer  "uid",             limit: 8
    t.string   "status_id_str"
  end

  create_table "users", force: true do |t|
    t.string   "screen_name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "image_url"
    t.integer  "followers_count"
    t.text     "token"
    t.text     "secret"
  end

  create_table "winners", force: true do |t|
    t.integer  "tweet_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prize_id"
  end

end
