FactoryGirl.define do
  factory :password_entry do
    sequence(:site_name) {|n| "MySiteName #{n}" }
    sequence(:site_url) {|n| "MySiteUrl #{n}" }
    username 'MyUsername'
    raw_password 'MyPassword'
    account

    after :build do |password_entry|
      password_entry.master_password = Account::HARDCODED_PASSWORD
    end
  end
end
