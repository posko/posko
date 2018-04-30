FactoryBot.define do
  factory :product do
    account
    title "Bread"
    trait :composite do
      product_type :composite
    end
  end
end
