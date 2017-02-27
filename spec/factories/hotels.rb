FactoryGirl.define do
  factory :hotel do
    name        {Faker::Name.name}
    description {Faker::Hipster.paragraph(10)}
  end
end
