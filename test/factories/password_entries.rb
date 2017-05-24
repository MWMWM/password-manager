FactoryGirl.define do
  factory :password_entry do
    sequence(:site_name) {|n| "MySiteName #{n}" }
    sequence(:site_url) {|n| "https://www.google.pl/search?q=#{n}" }
    sequence(:username) {|n| "MyUserName #{n}" }
    sequence(:raw_password) {|n| "MySecurePassword#{SecureRandom.base64(12)}" }
    account

    after :build do |password_entry|
      password_entry.master_password = Account::HARDCODED_PASSWORD
    end
  end
end
