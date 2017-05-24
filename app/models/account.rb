class Account < ApplicationRecord
  HARDCODED_USERNAME = ENV['HARDCODED_USERNAME']
  HARDCODED_PASSWORD = ENV['HARDCODED_PASSWORD']

  has_secure_password

  has_many :password_entries, dependent: :destroy

  validates :username, :password,
            presence: true
  validates :username,
            uniqueness: true
end
