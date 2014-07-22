class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :userProfileId
      t.text :notificationMessage
      t.boolean :isViewed
      t.datetime :notificationDateTime
      t.string :controllerName
      t.string :actionName
      t.references :user_profile
      t.timestamps
    end
    add_index :notifications, :user_profile_id
  end
end
