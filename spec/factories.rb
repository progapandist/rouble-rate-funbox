FactoryGirl.define do
  factory :exchange_rate do
    date (Time.current - 2.hours)
    rate 100
  end
end
