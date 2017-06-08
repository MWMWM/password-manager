class AddSharingsToPasswordEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :password_entries, :sharing_password_encrypted, :string
    add_column :password_entries, :sharing_iv, :string
  end
end
