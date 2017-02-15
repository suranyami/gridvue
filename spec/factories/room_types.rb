FactoryGirl.define do
  factory :room_type do
    name        {Faker::Commerce.color}
  end
end
