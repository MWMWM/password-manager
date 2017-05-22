FactoryGirl.define do
  factory :account do
    username Account::HARDCODED_USERNAME
    password Account::HARDCODED_PASSWORD
  end
end
