FactoryBot.define do
  factory :transaction do
    customer { association(:customer) }
    invoice
  end
end
