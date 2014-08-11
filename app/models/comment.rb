class Comment < ActiveRecord::Base
  belongs_to :user_profile
  validates :commentText, presence: true
  validates  :user_profile_id , presence: true
  validates :commentedBy , presence: true
end
