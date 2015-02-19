FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    password "secret"
    password_confirmation "secret"

    factory :invalid_user do
      name nil
    end
  end
end
