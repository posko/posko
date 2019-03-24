FactoryBot.define do
  factory :address do
    customer
    address1  { '404, Cebu City' }
    city      { 'Cebu' }
  end
end
