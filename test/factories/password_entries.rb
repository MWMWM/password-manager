FactoryGirl.define do
  factory :password_entry do
    site_name 'MySiteName'
    site_url 'MySiteUrl'
    username 'MyUsername'
    raw_password 'MyPassword'
    account

    after :build do |password_entry|
      password_entry.master_password = Account::HARDCODED_PASSWORD
    end
  end
end
