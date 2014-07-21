class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :commentedBy
      t.text :commentText
      t.string :commentType
      t.datetime :commentTimeDate
      t.references :UserProfile

      t.timestamps
    end
    add_index :comments, :UserProfile_id
  end
end
