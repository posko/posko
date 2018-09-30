FactoryBot.define do
  factory :shift_activity do
    shift
    date        { Time.current }
    amount      { 0 }
    remarks     { 'Sample String' }
    shift_activity_type { 'pay_in' }

    trait :pay_in do
      shift_activity_type { :pay_in }
    end

    trait :pay_out do
      shift_activity_type { :pay_out }
    end
  end
end
