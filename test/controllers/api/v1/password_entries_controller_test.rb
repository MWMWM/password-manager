require 'test_helper'

class Api::V1::PasswordEntriesControllerTest < ActionController::TestCase
  setup do
    @account = FactoryGirl.create :account
    @raw_password = "MySecurePassword#{SecureRandom.base64(12)}"
    @password_entry = FactoryGirl.create(:password_entry,
                                         account: @account,
                                         raw_password: @raw_password)
    @password_entry_params = FactoryGirl.attributes_for(:password_entry)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.
                                        encode_credentials(Account::HARDCODED_USERNAME,
                                                           Account::HARDCODED_PASSWORD)
  end

  test 'must get password entries belonging to an account' do
    get :index, format: :json
    assert_response :success
    assert_equal response.body,
                 [@password_entry].to_json(only: [:id, :site_name, :username])
  end

  test 'must not show password_entry if not providing auth data' do
    request.env['HTTP_AUTHORIZATION'] = ''
    get :show, params: { id: @password_entry.id }, format: :json
    assert_response 401
  end

  test 'must show password_entry if auth data provided' do
    get :show, params: { id: @password_entry.id }, format: :json
    assert_response :success
    expected_response = @password_entry.as_json(only: [:id, :site_name, :site_url, :username]).
                        merge(decrypted_password: @raw_password).to_json
    assert_equal response.body, expected_response
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

  test 'must generate sharing' do
    get :generate_sharing,
        params: { id: @password_entry.id },
        format: :json
    assert_response :success
    assert_equal response.body,
                 @password_entry.to_json(only: [:id],
                                         methods: [:generate_sharing_token])
  end

  test 'must get data from sharing and properly decrypt password' do
    @password_entry.master_password = Account::HARDCODED_PASSWORD
    @password_entry.encrypt_sharing_password
    sharing_token = @password_entry.generate_sharing_token
    get :use_sharing,
        params: { id: @password_entry.id, token: sharing_token }
    assert_response :success
    expected_response = @password_entry.as_json.
                        merge(decrypted_shared_password: @raw_password).to_json
    assert_equal response.body, expected_response
  end

  test 'must not get data from sharing if wrong token provided' do
    @password_entry.master_password = Account::HARDCODED_PASSWORD
    @password_entry.encrypt_sharing_password
    wrong_token = 'aaaa'
    get :use_sharing,
        params: { id: @password_entry.id, token: wrong_token }
    assert_response :success
    assert_equal response.body, { error: 'invalid token' }.to_json
  end
end
