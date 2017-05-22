account = Account.create(username: Account::HARDCODED_USERNAME,
                         password: Account::HARDCODED_PASSWORD)
12.times { FactoryGirl.create(:password_entry, account: account) }
