FactoryGirl.define do
  factory :password_entry do
    site_name 'MySiteUrl'
    site_url 'MySiteUrl'
    username 'MyUsername'
    password_encrypted 'MyPassword'
    iv 'MyIv'
    account
  end
end
