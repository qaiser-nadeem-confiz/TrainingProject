class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :emailId
      t.string :userName
      t.string :firstName
      t.string :secondName
      t.string :address
      t.string :education
      t.string :accountType
      t.string :phoneNumber
      t.date :dateOfBirth
      t.string :pictureUrl
      t.boolean :isActive
      t.datetime :dateOfJoining
      t.text :aboutMe

      t.timestamps
    end
  end
end
