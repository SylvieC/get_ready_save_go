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

ActiveRecord::Schema.define(version: 20140315190957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "name"
    t.string   "image"
    t.string   "url"
    t.string   "comment"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trips", force: true do |t|
    t.string   "from_city"
    t.string   "from_country"
    t.string   "to_city"
    t.string   "to_country"
    t.float    "money_saved"
    t.float    "add_to_money_saved"
    t.float    "cost"
    t.integer  "days_before_departure"
    t.integer  "months_before_departure"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
