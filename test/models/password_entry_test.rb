require 'test_helper'

class PasswordEntryTest < ActiveSupport::TestCase
  setup do
    @password_entry = FactoryGirl.build(:password_entry)
  end

  test 'must be valid' do
    assert_equal @password_entry.valid?, true
  end
end
