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

ActiveRecord::Schema[7.0].define(version: 2024_01_27_155119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "cep"
    t.string "street"
    t.string "complement"
    t.string "district"
    t.string "city"
    t.string "uf"
    t.string "ibge_code"
    t.bigint "citizen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["citizen_id"], name: "index_addresses_on_citizen_id"
  end

  create_table "citizens", force: :cascade do |t|
    t.string "full_name"
    t.string "cpf"
    t.string "cns"
    t.string "email"
    t.date "birthdate"
    t.string "phone_number"
    t.string "avatar"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cns"], name: "index_citizens_on_cns"
    t.index ["cpf"], name: "index_citizens_on_cpf"
    t.index ["email"], name: "index_citizens_on_email"
    t.index ["full_name"], name: "index_citizens_on_full_name"
  end

  add_foreign_key "addresses", "citizens"
end
