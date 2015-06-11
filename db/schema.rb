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

ActiveRecord::Schema.define(version: 20150611195859) do

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "submission_id"
    t.string   "value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["submission_id"], name: "index_answers_on_submission_id"

  create_table "questions", force: :cascade do |t|
    t.integer  "survey_id"
    t.integer  "order"
    t.string   "question_type"
    t.string   "value"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id"

  create_table "submissions", force: :cascade do |t|
    t.integer  "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "submissions", ["survey_id"], name: "index_submissions_on_survey_id"

  create_table "surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "description"
    t.boolean  "published"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "surveys", ["user_id"], name: "index_surveys_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
