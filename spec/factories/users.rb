FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Example User #{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password "secret"
    password_confirmation "secret"

    factory :invalid_user do
      name nil
    end
  end
end
