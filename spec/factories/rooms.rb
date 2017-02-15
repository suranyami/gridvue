FactoryGirl.define do
  factory :room do
    name        {Faker::Food.spice}
    hotel
  end
end
