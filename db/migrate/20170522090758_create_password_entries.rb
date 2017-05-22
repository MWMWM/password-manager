class CreatePasswordEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :password_entries do |t|
      t.string :site_name
      t.string :site_url
      t.string :username
      t.string :password_encrypted
      t.string :iv
      t.references :account

      t.timestamps
    end
  end
end
