FactoryGirl.define do
  factory :registration do
    sequence(:name) { |n| "Moe #{n}" }
    sequence(:email) { |n| "moe#{n}@stoogies.com" }
    how_heard "Web Search"
  end
end
