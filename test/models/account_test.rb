require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @account = FactoryGirl.build(:account)
  end

  test 'must be valid' do
    assert_equal @account.valid?, true
  end
end
