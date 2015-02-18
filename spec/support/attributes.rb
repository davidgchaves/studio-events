def event_attributes(overrides = {})
  {
    name: "BugSmash",
    location: "Denver",
    price: 10.00,
    description: "A fun evening of bug smashing",
    starts_at: 10.days.from_now,
    image_file_name: "bugsmash.png",
    capacity: 50
  }.merge(overrides)
end

def registration_attributes(overrides = {})
  {
    name: "Moe",
    email: "moe@stoogies.com",
    how_heard: "Web Search"
  }.merge(overrides)
end

