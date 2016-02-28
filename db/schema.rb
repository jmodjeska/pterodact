# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160228042707) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "catalog"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", force: :cascade do |t|
    t.integer  "course_id"
    t.integer  "student_id"
    t.integer  "courses_id"
    t.integer  "students_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["courses_id"], name: "index_enrollments_on_courses_id", using: :btree
  add_index "enrollments", ["students_id"], name: "index_enrollments_on_students_id", using: :btree

  create_table "offer_dates", force: :cascade do |t|
    t.integer  "course_id"
    t.datetime "date"
    t.integer  "size"
    t.integer  "courses_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offer_dates", ["courses_id"], name: "index_offer_dates_on_courses_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "department"
    t.integer  "moz_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "enrollments", "courses"
  add_foreign_key "enrollments", "students"
  add_foreign_key "offer_dates", "courses"
end
