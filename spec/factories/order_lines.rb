FactoryBot.define do
  factory :order_line do
    order
    variant
    price
  end
end
