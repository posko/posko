FactoryBot.define do
  factory :customer do
    account       { Account.first || create(:account) }
    first_name    "Juan"
    last_name     "Dela Cruz"
  end
end
