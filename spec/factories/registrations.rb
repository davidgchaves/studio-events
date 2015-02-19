FactoryGirl.define do
  factory :registration do
    association :event
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    how_heard "Web Search"
  end
end
