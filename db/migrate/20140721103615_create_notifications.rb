class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :userProfileId
      t.text :notificationMessage
      t.boolean :isViewed
      t.datetime :notificationDateTime
      t.references :UserProfile

      t.timestamps
    end
    add_index :notifications, :UserProfile_id
  end
end
