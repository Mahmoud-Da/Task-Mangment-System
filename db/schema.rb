# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_23_010238) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false, comment: "名前"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_categories", force: :cascade do |t|
    t.bigint "task_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_task_categories_on_category_id"
    t.index ["task_id"], name: "index_task_categories_on_task_id"
  end

  create_table "tasks", comment: "タスク詳細", force: :cascade do |t|
    t.string "title", null: false, comment: "タイトル"
    t.string "body", comment: "本文"
    t.date "limit", null: false, comment: "タスクの期限"
    t.integer "status", default: 0, null: false, comment: "ステータス"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority", default: 1, null: false, comment: "優先度"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
