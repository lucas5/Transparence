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

ActiveRecord::Schema.define(version: 2021_09_16_015547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "congresspeople", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "ide_registration"
    t.string "nu_parliamentary_card"
    t.string "political_party"
    t.string "sg_uf", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["cpf"], name: "index_congresspeople_on_cpf"
    t.index ["ide_registration"], name: "index_congresspeople_on_ide_registration"
    t.index ["name"], name: "index_congresspeople_on_name"
  end

  create_table "spendings", force: :cascade do |t|
    t.bigint "congressperson_id"
    t.date "emission_date"
    t.text "txt_provider"
    t.decimal "net_value"
    t.string "url_document"
    t.integer "num_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["congressperson_id"], name: "index_spendings_on_congressperson_id"
  end

  add_foreign_key "spendings", "congresspeople"
end
