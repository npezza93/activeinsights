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

ActiveRecord::Schema[7.1].define(version: 2024_01_11_225806) do
  create_table "active_insights_requests", force: :cascade do |t|
    t.string "controller"
    t.string "action"
    t.string "format"
    t.string "http_method"
    t.text "path"
    t.integer "status"
    t.float "view_runtime"
    t.float "db_runtime"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "uuid"
    t.float "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.virtual "formatted_controller", type: :string, as: "controller || '#'|| action", stored: true
    t.index ["duration", "started_at"], name: "index_active_insights_requests_on_duration_and_started_at"
    t.index ["started_at", "formatted_controller"], name: "idx_on_started_at_formatted_controller_417448339a"
    t.index ["started_at"], name: "index_active_insights_requests_on_started_at"
  end

end
