FactoryBot.define do
  factory :option_value do
    option_type { association(:option_type, name: 'Size') }
    name { 'Large' }
  end
end
