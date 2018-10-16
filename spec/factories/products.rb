FactoryBot.define do
  factory :product do
    account
    created_by { association(:user) }
    title { 'Bread' }
    trait :composite do
      product_type { :composite }
    end

    transient do
      variant_count { 0 }
    end

    trait :with_variant do
      transient do
        variant_count { 1 }
      end
    end

    after(:create) do |product, evaluator|
      if evaluator.variant_count > 0
        create_list(:variant, evaluator.variant_count, product: product)
      end
    end
  end
end
