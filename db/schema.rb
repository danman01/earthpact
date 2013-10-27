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

ActiveRecord::Schema.define(version: 20131026194203) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributions", force: true do |t|
    t.float    "charity_split"
    t.float    "earthpact_split"
    t.decimal  "amount"
    t.integer  "last_four"
    t.string   "payment_provider"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contributions", ["user_id"], name: "index_contributions_on_user_id", using: :btree

  create_table "logs", force: true do |t|
    t.integer  "amount_used"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "week_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["user_id"], name: "index_logs_on_user_id", using: :btree

  create_table "pacts", force: true do |t|
    t.boolean  "agreed"
    t.decimal  "balance",    precision: 8, scale: 2
    t.decimal  "penalty",    precision: 8, scale: 2
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pacts", ["user_id"], name: "index_pacts_on_user_id", using: :btree

  create_table "services", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "nickname"
    t.string   "access_token"
    t.datetime "token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_id"
  end

  create_table "weeks", force: true do |t|
    t.datetime "start_day"
    t.datetime "end_day"
    t.decimal  "total_contributed", precision: 8, scale: 2
    t.integer  "total_used"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
