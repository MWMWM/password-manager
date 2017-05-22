require 'test_helper'

class Api::V1::PasswordEntriesControllerTest < ActionController::TestCase
  setup do
    @account = FactoryGirl.create :account
    @password_entry = FactoryGirl.create :password_entry, account: @account
   end

  test 'must not show password_entry if not providing auth data' do
    get :show, params: { id: @password_entry.id }, format: :json
    assert_response 401
    assert_equal response.body, { errors: 'Not authenticated' }.to_json
  end

  test 'must show password_entry if auth data provided' do
    request.headers['Username'] = @account.username
    request.headers['Password'] = 'MasterPassword'
    get :show, params: { id: @password_entry.id }, format: :json
    assert_response :success
    assert_equal response.body, @password_entry.to_json
  end
end
