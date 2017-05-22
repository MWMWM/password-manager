require 'test_helper'

class Api::V1::PasswordEntriesControllerTest < ActionController::TestCase
  setup do
    @account = FactoryGirl.create :account
    @password_entry = FactoryGirl.create :password_entry, account: @account
    @password_entry_params = FactoryGirl.attributes_for(:password_entry)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(Account::HARDCODED_USERNAME, Account::HARDCODED_PASSWORD)
  end

  test 'must not show password_entry if not providing auth data' do
    request.env['HTTP_AUTHORIZATION'] = ''
    get :show, params: { id: @password_entry.id }, format: :json
    assert_response 401
  end

  test 'must show password_entry if auth data provided' do
    get :show, params: { id: @password_entry.id }, format: :json
    assert_response :success
    assert_equal response.body,
                 @password_entry.to_json(only: [:site_name, :site_url, :username],
                                         methods: [:decrypted_password])
  end

  test 'must create password_entry if auth data provided' do
    assert_difference 'PasswordEntry.count', 1 do
      post :create,
           params: { password_entry: @password_entry_params },
           format: :json
    end
    assert_response :success
    assert_equal response.body,
                 PasswordEntry.last.to_json(only: [:id, :site_name])
  end

  test 'must update password_entry if auth data provided' do
    @password_entry_params[:site_name] = 'NewSiteName'
    put :update,
        params: { id: @password_entry.id,
                  password_entry: @password_entry_params },
        format: :json
    assert_response :success
    assert_empty response.body

    @password_entry.reload
    assert_equal @password_entry.site_name, 'NewSiteName'
  end

  test 'must destroy password_entry if auth data provided' do
    assert_difference 'PasswordEntry.count', -1 do
      delete :destroy,
             params: { id: @password_entry.id },
             format: :json
    end
    assert_response :success
    assert_empty response.body
  end
end
