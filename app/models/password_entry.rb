class PasswordEntry < ApplicationRecord
  belongs_to :account

  attr_accessor :raw_password
  attr_accessor :master_password

  validates :site_name, :site_url, :username, :password_encrypted, :iv,
            presence: true

  before_validation :encrypt

  def encrypt
    return unless raw_password
    return unless master_password

    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = Digest::SHA256.digest(master_password)
    self.iv = Base64.encode64(cipher.random_iv)
    password_encrypted = cipher.update(raw_password) + cipher.final
    self.password_encrypted = Base64.encode64(password_encrypted)
  end

  def decrypted_password
    return unless master_password

    decipher = OpenSSL::Cipher::AES.new(256, :CBC)
    decipher.decrypt
    decipher.key = Digest::SHA256.digest(master_password)
    decipher.iv = Base64.decode64(iv)
    decipher.update(Base64.decode64(password_encrypted)) + decipher.final
  end

  def as_json(_options)
    super(only: [:site_name, :site_url, :username],
          methods: [:decrypted_password])
  end
end
