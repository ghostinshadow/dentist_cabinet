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

ActiveRecord::Schema.define(version: 20170121131435) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.date     "creation_time"
    t.integer  "patient_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["patient_id"], name: "index_appointments_on_patient_id", using: :btree
  end

  create_table "dictionaries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",         limit: 100
    t.string   "resource_type", limit: 100
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["user_id"], name: "index_dictionaries_on_user_id", using: :btree
  end

  create_table "patient_pictures", force: :cascade do |t|
    t.integer  "patient_id"
    t.string   "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_patient_pictures_on_patient_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.string   "last_name",        limit: 100
    t.string   "first_name",       limit: 100
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.boolean  "milk_teeth"
    t.date     "birth_day"
    t.integer  "town_id"
    t.string   "telephone"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "email",            limit: 50
    t.string   "backup_telephone", limit: 20
    t.index ["doctor_id"], name: "index_patients_on_doctor_id", using: :btree
    t.index ["town_id"], name: "index_patients_on_town_id", using: :btree
    t.index ["user_id"], name: "index_patients_on_user_id", using: :btree
  end

  create_table "performed_works", force: :cascade do |t|
    t.integer  "dictionary_id"
    t.integer  "word_id"
    t.integer  "appointment_id"
    t.decimal  "price",          precision: 7, scale: 2
    t.text     "teeth_nums"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["appointment_id"], name: "index_performed_works_on_appointment_id", using: :btree
    t.index ["dictionary_id"], name: "index_performed_works_on_dictionary_id", using: :btree
    t.index ["word_id"], name: "index_performed_works_on_word_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "words", force: :cascade do |t|
    t.integer  "dictionary_id"
    t.string   "title",         limit: 100
    t.string   "body",          limit: 100
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["dictionary_id"], name: "index_words_on_dictionary_id", using: :btree
  end

end
