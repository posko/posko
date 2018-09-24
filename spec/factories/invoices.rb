FactoryBot.define do
  factory :invoice do
    account
    customer
    user

    invoice_number            { 1001 }
    total_line_items_price    { 110 }
    total_discounts           { 10 }
    subtotal                  { 100 }
    total_tax                 { 10 }
    total_price               { 110 }
    total_weight              { 2 }
  end
end
