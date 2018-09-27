FactoryBot.define do
  factory :shift do
    user
    start_date    { Time.current }
    end_date      { Time.current + 1.day }
    starting_cash { 0 }
    payments      { 0 }
    paid_in       { 0 }
    paid_out      { 0 }
    cash          { 0 }
  end
end
