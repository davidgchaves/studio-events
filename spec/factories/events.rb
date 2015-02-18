FactoryGirl.define do
  factory :event do
    sequence(:name) { |n| "BugSmash #{n}" }
    location "Denver"
    price 10.00
    sequence(:description) { |n| "A fun evening of bug smashing #{n}" }
    starts_at 10.days.from_now
    image_file_name ""
    capacity 50
  end
end
