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

ActiveRecord::Schema.define(version: 20180201210624) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_snapshots", force: :cascade do |t|
    t.jsonb "data", default: "{}"
    t.integer "todo_list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["todo_list_id"], name: "index_daily_snapshots_on_todo_list_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "sender_id"
    t.string "unique_token"
    t.string "stripe_charge_id"
    t.string "recipient_email"
    t.text "message"
    t.string "recipient_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unique_token"], name: "index_gifts_on_unique_token", unique: true
  end

  create_table "payola_affiliates", id: :serial, force: :cascade do |t|
    t.string "code"
    t.string "email"
    t.integer "percent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_coupons", id: :serial, force: :cascade do |t|
    t.string "code"
    t.integer "percent_off"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "active", default: true
  end

  create_table "payola_sales", id: :serial, force: :cascade do |t|
    t.string "email", limit: 191
    t.string "guid", limit: 191
    t.integer "product_id"
    t.string "product_type", limit: 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "state"
    t.string "stripe_id"
    t.string "stripe_token"
    t.string "card_last4"
    t.date "card_expiration"
    t.string "card_type"
    t.text "error"
    t.integer "amount"
    t.integer "fee_amount"
    t.integer "coupon_id"
    t.boolean "opt_in"
    t.integer "download_count"
    t.integer "affiliate_id"
    t.text "customer_address"
    t.text "business_address"
    t.string "stripe_customer_id", limit: 191
    t.string "currency"
    t.text "signed_custom_fields"
    t.integer "owner_id"
    t.string "owner_type", limit: 100
    t.index ["coupon_id"], name: "index_payola_sales_on_coupon_id"
    t.index ["email"], name: "index_payola_sales_on_email"
    t.index ["guid"], name: "index_payola_sales_on_guid"
    t.index ["owner_id", "owner_type"], name: "index_payola_sales_on_owner_id_and_owner_type"
    t.index ["product_id", "product_type"], name: "index_payola_sales_on_product"
    t.index ["stripe_customer_id"], name: "index_payola_sales_on_stripe_customer_id"
  end

  create_table "payola_stripe_webhooks", id: :serial, force: :cascade do |t|
    t.string "stripe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payola_subscriptions", id: :serial, force: :cascade do |t|
    t.string "plan_type"
    t.integer "plan_id"
    t.datetime "start"
    t.string "status"
    t.string "owner_type"
    t.integer "owner_id"
    t.string "stripe_customer_id"
    t.boolean "cancel_at_period_end"
    t.datetime "current_period_start"
    t.datetime "current_period_end"
    t.datetime "ended_at"
    t.datetime "trial_start"
    t.datetime "trial_end"
    t.datetime "canceled_at"
    t.integer "quantity"
    t.string "stripe_id"
    t.string "stripe_token"
    t.string "card_last4"
    t.date "card_expiration"
    t.string "card_type"
    t.text "error"
    t.string "state"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "currency"
    t.integer "amount"
    t.string "guid", limit: 191
    t.string "stripe_status"
    t.integer "affiliate_id"
    t.string "coupon"
    t.text "signed_custom_fields"
    t.text "customer_address"
    t.text "business_address"
    t.integer "setup_fee"
    t.decimal "tax_percent", precision: 4, scale: 2
    t.index ["guid"], name: "index_payola_subscriptions_on_guid"
  end

  create_table "reflections", id: :serial, force: :cascade do |t|
    t.integer "rating"
    t.text "negative"
    t.text "positive"
    t.date "date"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_reflections_on_user_id"
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.integer "amount"
    t.string "interval"
    t.string "stripe_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todo_lists", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "list_type", default: "daily", null: false
    t.integer "week_plan_id"
    t.index ["user_id"], name: "index_todo_lists_on_user_id"
  end

  create_table "todos", id: :serial, force: :cascade do |t|
    t.string "content"
    t.boolean "complete", default: false
    t.integer "estimated_time_blocks", default: 0
    t.integer "actual_time_blocks", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "daily_todo_list_id"
    t.integer "weekly_todo_list_id"
    t.index ["daily_todo_list_id"], name: "index_todos_on_daily_todo_list_id"
    t.index ["weekly_todo_list_id"], name: "index_todos_on_weekly_todo_list_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "track_weekends", default: true
    t.string "timezone"
    t.boolean "paid", default: false, null: false
    t.boolean "guest"
    t.string "google_id"
    t.string "stripe_charge_id"
    t.boolean "weekly_summary", default: false
    t.string "password_reset_token"
    t.datetime "password_reset_token_expiration"
    t.string "referral_code"
    t.integer "referred_by"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["referred_by"], name: "index_users_on_referred_by"
  end

  create_table "weekly_summaries", force: :cascade do |t|
    t.integer "completion_percentage", default: 0
    t.integer "weekly_rating", default: 0
    t.text "todo_list_ids", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_weekly_summaries_on_user_id"
  end

  add_foreign_key "daily_snapshots", "todo_lists"
  add_foreign_key "reflections", "users"
  add_foreign_key "todo_lists", "users"
  add_foreign_key "todos", "todo_lists", column: "daily_todo_list_id"
  add_foreign_key "todos", "todo_lists", column: "weekly_todo_list_id"
end
