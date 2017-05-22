require 'test_helper'

class PasswordEntryTest < ActiveSupport::TestCase
  setup do
    @password_entry = FactoryGirl.build(:password_entry)
  end

  test 'must be valid' do
    assert_equal @password_entry.valid?, true
  end

  test 'encrypting' do
    @password_entry.raw_password = 'MyPass'
    @password_entry.encrypt('MasterPassword')
    assert_not_equal @password_entry.iv, 'MyIv'
    assert_not_equal @password_entry.password_encrypted, 'MyPassword'
  end

  test 'decrypting encrypted password must return initial plain password' do
    @password_entry.raw_password = 'MyPass'
    @password_entry.encrypt('MasterPassword')
    plain = @password_entry.decrypt('MasterPassword')
    assert_equal plain, 'MyPass'
  end
end
