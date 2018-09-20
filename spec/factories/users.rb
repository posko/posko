FactoryBot.define do
  factory :user do
    account               { create(:account) }
    sequence(:email)      { |n| "user#{n}@example.com" }
    sequence(:first_name) { |n| "Juan#{n}" }
    middle_name           'Masigasig'
    sequence(:last_name)  { |n| "Dela Cruz#{n}" }
    suffix                'Jr.'
    title                 'Mr'
    password              { 'password' }

    transient do
      access_key_count 1
    end

    after(:create) do |user, evaluator|
      evaluator.access_key_count.times do
        create_list(:access_key, 1, user: user)
      end
    end
  end
end
