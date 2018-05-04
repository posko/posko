FactoryBot.define do
  factory :product do
    account
    created_by { association(:user) }
    title "Bread"
    trait :composite do
      product_type :composite
    end
  end
end
