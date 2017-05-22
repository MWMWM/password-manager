class Account < ApplicationRecord
  has_secure_password

  has_many :password_entries, dependent: :destroy

  validates :username, :password,
            presence: true
end
