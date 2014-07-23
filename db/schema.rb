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

ActiveRecord::Schema.define(:version => 20140723084255) do

  create_table "account_model_views", :force => true do |t|
    t.string   "userName"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", :force => true do |t|
    t.string   "emailId"
    t.string   "userName"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentedBy"
    t.text     "commentText"
    t.string   "commentType"
    t.datetime "commentTimeDate"
    t.integer  "user_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["user_profile_id"], :name => "index_comments_on_user_profile_id"

  create_table "friend_lists", :force => true do |t|
    t.integer  "userId"
    t.integer  "friendsWithId"
    t.boolean  "requestAccepted"
    t.date     "dateOfFriendShip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friend_requests", :force => true do |t|
    t.string   "requestFrom"
    t.string   "requestTo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "userProfileId"
    t.text     "notificationMessage"
    t.boolean  "isViewed"
    t.datetime "notificationDateTime"
    t.string   "controllerName"
    t.string   "actionName"
    t.integer  "user_profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_profile_id"], :name => "index_notifications_on_user_profile_id"

  create_table "user_profiles", :force => true do |t|
    t.string   "emailId"
    t.string   "userName"
    t.string   "firstName"
    t.string   "secondName"
    t.string   "address"
    t.string   "education"
    t.string   "accountType"
    t.string   "phoneNumber"
    t.date     "dateOfBirth"
    t.string   "pictureUrl"
    t.boolean  "isActive"
    t.datetime "dateOfJoining"
    t.text     "aboutMe"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
