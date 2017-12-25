FactoryBot.define do
  factory :user do
    account         { create(:account) }
    email           { generate(:email_sequence) }
    first_name      { generate(:first_name_sequence) }
    middle_name     "Masigasig"
    last_name       { generate(:last_name_sequence) }
    suffix          "Jr."
    title           "Mr"
    password        { generate(:email_sequence) }
  end

  sequence :email_sequence do |n|
    "user#{n}@example.com"
  end
  sequence :first_name_sequence do |n|
    "Juan#{n}"
  end
  sequence :last_name_sequence do |n|
    "Dela Cruz#{n}@example.com"
  end
end
