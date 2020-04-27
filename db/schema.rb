# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_27_193545) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.citext "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "categorizations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "custom_design_id", null: false
    t.uuid "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_categorizations_on_category_id"
    t.index ["custom_design_id", "category_id"], name: "index_categorizations_on_custom_design_id_and_category_id", unique: true
    t.index ["custom_design_id"], name: "index_categorizations_on_custom_design_id"
  end

  create_table "creators", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "name", limit: 10
    t.string "creator_id", limit: 17
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_creators_on_creator_id", unique: true, where: "(creator_id IS NOT NULL)"
    t.index ["user_id"], name: "index_creators_on_user_id"
  end

  create_table "custom_designs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "creator_id", null: false
    t.uuid "main_picture_id", null: false
    t.uuid "example_picture_id"
    t.string "name", null: false
    t.string "design_id", limit: 17, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["creator_id"], name: "index_custom_designs_on_creator_id"
    t.index ["design_id"], name: "index_custom_designs_on_design_id", unique: true
    t.index ["example_picture_id"], name: "index_custom_designs_on_example_picture_id"
    t.index ["main_picture_id"], name: "index_custom_designs_on_main_picture_id"
  end

  create_table "pictures", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "image_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "taggings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "custom_design_id", null: false
    t.uuid "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["custom_design_id", "tag_id"], name: "index_taggings_on_custom_design_id_and_tag_id", unique: true
    t.index ["custom_design_id"], name: "index_taggings_on_custom_design_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", limit: 20, null: false
    t.citext "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["slug"], name: "index_tags_on_slug", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "categorizations", "categories"
  add_foreign_key "categorizations", "custom_designs"
  add_foreign_key "creators", "users"
  add_foreign_key "custom_designs", "creators"
  add_foreign_key "custom_designs", "pictures", column: "example_picture_id"
  add_foreign_key "custom_designs", "pictures", column: "main_picture_id"
  add_foreign_key "taggings", "custom_designs"
  add_foreign_key "taggings", "tags"
end
