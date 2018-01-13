FactoryBot.define do
  factory :user_role do
    user  { association(:user) }
    role { association(:role) }
  end
end
