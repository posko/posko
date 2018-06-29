FactoryBot.define do
  factory :invoice_line do
    invoice
    product { association(:product) }
    variant { association(:variant, product: product) }
    price   1000
  end
end
