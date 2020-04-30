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

ActiveRecord::Schema.define(version: 2020_04_09_011808) do

  create_table "anniversaries", force: :cascade do |t|
    t.date "date"
    t.string "title"
    t.text "memo"
    t.integer "portrait_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portrait_id"], name: "index_anniversaries_on_portrait_id"
    t.index ["title"], name: "index_anniversaries_on_title"
    t.index ["user_id"], name: "index_anniversaries_on_user_id"
  end

  create_table "bouquets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "portrait_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portrait_id"], name: "index_bouquets_on_portrait_id"
    t.index ["user_id"], name: "index_bouquets_on_user_id"
  end

  create_table "flowers", force: :cascade do |t|
    t.integer "user_id"
    t.integer "memory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["memory_id"], name: "index_flowers_on_memory_id"
    t.index ["user_id"], name: "index_flowers_on_user_id"
  end

  create_table "memories", force: :cascade do |t|
    t.integer "portrait_id"
    t.string "title", default: "", null: false
    t.string "when"
    t.text "memory"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portrait_id"], name: "index_memories_on_portrait_id"
    t.index ["title"], name: "index_memories_on_title"
  end

  create_table "notificarions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "portrait_id"
    t.integer "memory_id"
    t.integer "bouquet_id"
    t.integer "flower_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "portraits", force: :cascade do |t|
    t.integer "user_id"
    t.string "image_id"
    t.string "name", default: "", null: false
    t.string "gender"
    t.integer "age"
    t.string "species"
    t.date "birthday"
    t.date "anniversary"
    t.string "likes_and_dislikes"
    t.string "interest"
    t.string "specialty"
    t.string "family"
    t.string "personality"
    t.string "found"
    t.text "more_about_me"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_portraits_on_name"
    t.index ["species"], name: "index_portraits_on_species"
    t.index ["user_id"], name: "index_portraits_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id", "follower_id"], name: "index_relationships_on_followed_id_and_follower_id", unique: true
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "image_id"
    t.text "introduction"
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
