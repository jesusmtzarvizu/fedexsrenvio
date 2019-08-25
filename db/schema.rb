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

ActiveRecord::Schema.define(version: 2019_08_25_233320) do

  create_table "packages", force: :cascade do |t|
    t.string "tracking_number", limit: 50
    t.string "fcarrier", limit: 30
    t.string "flength", limit: 10
    t.string "fwidth", limit: 10
    t.string "fheight", limit: 10
    t.string "fweight", limit: 10
    t.string "fdistance_unit", limit: 10
    t.string "fmass_unit", limit: 10
    t.string "jlength", limit: 10
    t.string "jwidth", limit: 10
    t.string "jheight", limit: 10
    t.string "jweight", limit: 10
    t.string "jdistance_unit", limit: 10
    t.string "jmass_unit", limit: 10
    t.string "eweight", limit: 10
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
