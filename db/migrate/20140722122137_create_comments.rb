class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentedBy
      t.text :commentText
      t.string :commentType
      t.datetime :commentTimeDate
      t.references :user_profile
      t.timestamps
    end
    add_index :comments, :user_profile_id
  end
end
