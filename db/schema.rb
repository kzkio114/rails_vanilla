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

ActiveRecord::Schema[8.0].define(version: 2025_01_28_134522) do
  create_table "omikuji_histories", force: :cascade do |t|
    t.integer "snake_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["snake_id"], name: "index_omikuji_histories_on_snake_id"
  end

  create_table "omikuji_results", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "snake_colors", force: :cascade do |t|
    t.integer "snake_id", null: false
    t.string "layer"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "horizontal_line"
    t.boolean "vertical_line"
    t.boolean "circle"
    t.index ["snake_id"], name: "index_snake_colors_on_snake_id"
  end

  create_table "snakes", force: :cascade do |t|
    t.string "name"
    t.integer "omikuji_result_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["omikuji_result_id"], name: "index_snakes_on_omikuji_result_id"
  end

  add_foreign_key "omikuji_histories", "snakes"
  add_foreign_key "snake_colors", "snakes"
  add_foreign_key "snakes", "omikuji_results"
end
