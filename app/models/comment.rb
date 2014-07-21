class Comment < ActiveRecord::Base
  belongs_to :UserProfile
end
