class Account < ApplicationRecord
  HARDCODED_USERNAME = 'myaccount'
  HARDCODED_PASSWORD = 'MySuperSecureAndLongPassword:)'

  has_secure_password

  has_many :password_entries, dependent: :destroy

  validates :username, :password,
            presence: true
  validates :username,
            uniqueness: true
end
