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

ActiveRecord::Schema[7.1].define(version: 2025_06_14_211246) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "material_types", force: :cascade do |t|
    t.string "name"
    t.string "metric_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.float "amount"
    t.float "price"
    t.float "price_per_amount"
    t.string "observation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "supplier_id", null: false
    t.bigint "material_type_id", null: false
    t.index ["material_type_id"], name: "index_materials_on_material_type_id"
    t.index ["supplier_id"], name: "index_materials_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "phone_number"
    t.string "social_media"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "materials", "material_types"
  add_foreign_key "materials", "suppliers"
end
