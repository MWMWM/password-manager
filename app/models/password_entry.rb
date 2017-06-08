class PasswordEntry < ApplicationRecord
  TOKEN_SEPARATOR = '_'

  belongs_to :account

  attr_accessor :raw_password
  attr_accessor :master_password
  attr_accessor :sharing_token

  validates :site_name, :site_url, :username, :password_encrypted, :iv,
            presence: true
  validates :username,
            uniqueness: { scope: [:account_id, :site_name] }

  before_validation :encrypt

  def encrypt
    return unless raw_password
    return unless master_password

    self.iv, self.password_encrypted = perform_encryption(raw_password, master_password)
  end

  def decrypted_password
    return unless master_password

    perform_decryption(password_encrypted, master_password, iv)
  end

  def encrypt_sharing_password
    self.sharing_iv, self.sharing_password_encrypted = perform_encryption(decrypted_password, generate_sharing_password)
    self.save
  end

  def decrypted_shared_password
    password = get_password_from_sharing_token
    perform_decryption(sharing_password_encrypted, password, sharing_iv)
  end

  def generate_sharing_token
    token = generate_sharing_password + TOKEN_SEPARATOR + generate_timestamp
    _iv, token_encrypted = perform_encryption(token,
                                              Rails.application.secrets.secret_sharing_password,
                                              Rails.application.secrets.secret_sharing_iv, true)
    token_encrypted
  end

  def valid_token?
    timestamp = get_timestamp_from_sharing_token
    Time.current - Time.at(timestamp.to_i) < 5.minutes
  end

  private

  def perform_decryption(encrypted, password, iv, url_safe = false)
    begin
      decipher = OpenSSL::Cipher::AES.new(256, :CBC)
      decipher.decrypt
      decipher.key = Digest::SHA256.digest(password)
      decipher.iv = Base64.decode64(iv)
      decoded = url_safe ? Base64.urlsafe_decode64(encrypted) : Base64.decode64(encrypted)
      decipher.update(decoded) + decipher.final
    rescue OpenSSL::Cipher::CipherError
      ''
    end
  end

  def perform_encryption(raw, password, iv = nil, url_safe = false)
    cipher = OpenSSL::Cipher::AES.new(256, :CBC)
    cipher.encrypt
    cipher.key = Digest::SHA256.digest(password)
    if iv
      cipher.iv = Base64.decode64(iv)
    else
      iv = Base64.encode64(cipher.random_iv)
    end
    encrypted = cipher.update(raw) + cipher.final
    encoded = url_safe ? Base64.urlsafe_encode64(encrypted) : Base64.encode64(encrypted)
    return iv, encoded
  end

  def generate_sharing_password
    return unless master_password

    Digest::SHA256.digest(master_password + id.to_s)
  end

  def generate_timestamp
    Time.current.to_i.to_s
  end

  def get_password_from_sharing_token
    decrypted_token.split(TOKEN_SEPARATOR)[0]
  end

  def get_timestamp_from_sharing_token
    decrypted_token.split(TOKEN_SEPARATOR)[1]
  end

  def decrypted_token
    perform_decryption(sharing_token,
                       Rails.application.secrets.secret_sharing_password,
                       Rails.application.secrets.secret_sharing_iv, true)
  end
end
