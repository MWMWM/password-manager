class PasswordEntry < ApplicationRecord
  belongs_to :account

  attr_accessor :raw_password

  validates :site_name, :site_url, :username, :password_encrypted, :iv,
            presence: true

  def encrypt(master_password)
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = Digest::SHA256.digest(master_password)
    self.iv = cipher.random_iv
    self.password_encrypted = cipher.update(raw_password) + cipher.final
  end

  def decrypt(master_password)
    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = Digest::SHA256.digest(master_password)
    decipher.iv = iv
    decipher.update(encrypted) + decipher.final
  end
end
