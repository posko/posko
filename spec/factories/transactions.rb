FactoryBot.define do
  factory :transaction do
    customer { association(:customer) }
    order
  end
end
