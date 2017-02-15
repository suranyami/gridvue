FactoryGirl.define do
  factory :room_rate do
    price     {Faker::Commerce.price}
    from_date {Faker::Time.between(DateTime.now + 7, DateTime.now + 365)}
    to_date   {from_date + Faker::Number.between(7, 30).days}
    room_type
    hotel
  end
end
