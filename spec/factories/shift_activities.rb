FactoryBot.define do
  factory :shift_activity do
    shift
    date        { Time.current }
    amount      { 0 }
    remarks     { 'Sample String' }
    shift_activity_type { 'pay_in' }
  end
end
