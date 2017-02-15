FactoryGirl.define do
  factory :hotel do
    name        {Faker::Name.name}
    description {Faker::Hipster.paragraph(1)}
  end
end
