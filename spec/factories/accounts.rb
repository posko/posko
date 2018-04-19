FactoryBot.define do
  factory :account do
    sequence(:name) { |x| "my_company#{x}" }
    sequence(:company) { |x| "My Company#{x}" }
  end
end
