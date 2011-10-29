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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111029145437) do

  create_table "items", :force => true do |t|
    t.string  "description", :limit => 200, :null => false
    t.integer "price",                      :null => false
    t.integer "merchant_id",                :null => false
  end

  add_index "items", ["merchant_id", "description", "price"], :name => "index_items_on_merchant_id_and_description_and_price"
  add_index "items", ["merchant_id"], :name => "index_items_on_merchant_id"

  create_table "merchants", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.string   "address",    :limit => 250, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merchants", ["name", "address"], :name => "index_merchants_on_name_and_address"

  create_table "purchasers", :force => true do |t|
    t.string   "name",       :limit => 100, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "purchasers", ["name"], :name => "index_purchasers_on_name"

  create_table "purchases", :force => true do |t|
    t.integer "purchaser_id", :null => false
    t.integer "item_id",      :null => false
    t.integer "count",        :null => false
  end

  add_index "purchases", ["item_id"], :name => "index_purchases_on_item_id"
  add_index "purchases", ["purchaser_id"], :name => "index_purchases_on_purchaser_id"

  create_table "upload_messages", :force => true do |t|
    t.integer "upload_id",                 :null => false
    t.string  "message",    :limit => 250, :null => false
    t.integer "row_number"
    t.string  "type",       :limit => 15
  end

  create_table "uploads", :force => true do |t|
    t.string   "file_uid",   :limit => 200, :null => false
    t.string   "file_name",  :limit => 100, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "start_time"
    t.datetime "end_time"
  end

end
