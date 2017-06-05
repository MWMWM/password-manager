FactoryGirl.define do
  factory :sharing do
    encrypted_password 'MyTokenEncryptedPassword'
    password_entry
  end
end
