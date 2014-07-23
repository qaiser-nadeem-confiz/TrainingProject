class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.string :requestFrom
      t.string :requestTo

      t.timestamps
    end
  end
end
