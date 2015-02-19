FactoryGirl.define do
  factory :event do
    name { Faker::Name.first_name }
    location { Faker::Address.city }
    price { Faker::Commerce.price }
    description { Faker::Lorem.sentence(8, false, 0) }
    starts_at { Faker::Date.forward(10) }
    image_file_name ""
    capacity 50
  end
end
