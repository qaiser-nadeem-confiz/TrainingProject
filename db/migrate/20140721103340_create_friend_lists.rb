class CreateFriendLists < ActiveRecord::Migration
  def change
    create_table :friend_lists do |t|
      t.integer :userId
      t.integer :friendsWithId
      t.boolean :requestAccepted
      t.date :dateOfFriendShip

      t.timestamps
    end
  end
end
