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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150401112047) do

  create_table "answers", :force => true do |t|
    t.string   "content"
    t.integer  "question_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.boolean  "correct"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "century_timelines", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "person"
    t.datetime "period"
    t.string   "impact_type"
    t.integer  "history_timeline_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "friendships", ["friend_id"], :name => "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], :name => "index_friendships_on_user_id"

  create_table "game_details", :force => true do |t|
    t.integer  "game_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "game_details", ["answer_id"], :name => "index_game_details_on_answer_id"
  add_index "game_details", ["game_id"], :name => "index_game_details_on_game_id"
  add_index "game_details", ["question_id"], :name => "index_game_details_on_question_id"

  create_table "games", :force => true do |t|
    t.integer  "user_id"
    t.integer  "quizz_id"
    t.integer  "points"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "emailed"
    t.string   "state"
    t.integer  "max_score"
  end

  add_index "games", ["quizz_id"], :name => "index_games_on_quizz_id"
  add_index "games", ["user_id"], :name => "index_games_on_user_id"

  create_table "history_timelines", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "questions", :force => true do |t|
    t.string   "title"
    t.integer  "quizz_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["quizz_id"], :name => "index_questions_on_quizz_id"

  create_table "quizzs", :force => true do |t|
    t.string   "description", :default => "", :null => false
    t.string   "status"
    t.integer  "created_by"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "name",                   :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "admin",                  :default => false, :null => false
    t.string   "role"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "notification"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
