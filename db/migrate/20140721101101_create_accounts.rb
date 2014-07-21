class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :emailId
      t.string :userName
      t.string :password

      t.timestamps
    end
  end
end
