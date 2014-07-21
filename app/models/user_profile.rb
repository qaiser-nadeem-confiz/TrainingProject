class UserProfile < ActiveRecord::Base
  has_many :comments
  has_many :notifications
end
