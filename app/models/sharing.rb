class Sharing < ApplicationRecord
  belongs_to :password_entry

  attr_accessor :token

  def password_from_sharing
    return unless ((Time.current - created_at) < 5.minutes)
    # decrypt password with provided token
  end
end
