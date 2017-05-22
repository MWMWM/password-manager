require 'test_helper'

class PasswordEntryTest < ActiveSupport::TestCase
  setup do
    @password_entry = FactoryGirl.build(:password_entry)
  end

  test 'must be valid' do
    assert_equal @password_entry.valid?, true
  end

  test 'encrypting' do
    iv = @password_entry.iv
    password_encrypted = @password_entry.password_encrypted
    @password_entry.raw_password = 'MyPass'
    @password_entry.encrypt
    assert_not_equal @password_entry.iv, iv
    assert_not_equal @password_entry.password_encrypted, password_encrypted
  end

  test 'decrypting encrypted password must return initial plain password' do
    @password_entry.raw_password = 'MyPass'
    @password_entry.encrypt
    assert_equal @password_entry.decrypted_password, 'MyPass'
  end
end
