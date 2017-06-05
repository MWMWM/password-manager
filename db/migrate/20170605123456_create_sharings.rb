class CreateSharings < ActiveRecord::Migration[5.1]
  def change
    create_table :sharings do |t|
      t.string :encrypted_password
      t.references :password_entry, foreign_key: true

      t.timestamps
    end
  end
end
