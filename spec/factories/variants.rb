FactoryBot.define do
  factory :variant do
    product
    price    { 100 }
    title    { 'Large' }
    barcode  { '19999191' }
  end
end
