FactoryBot.define do
  factory :order_line do
    order
    product { association(:product) }
    variant { association(:variant, product: product) }
    price   1000
  end
end
