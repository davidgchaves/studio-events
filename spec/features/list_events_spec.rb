require "rails_helper"

describe "Viewing the list of events" do
  let!(:event1) { Event.create name: "BugSmash",
                               location: "Denver",
                               price: 10.00,
                               description: "A fun evening of bug smashing",
                               starts_at: 10.days.from_now,
                               capacity: 55,
                               image_file_name: "bugsmash.png" }

  let!(:past_event) { Event.create name: "Coffee and Code",
                                   location: "Stumpron Coffee, Portland",
                                   price: 0.00,
                                   description: "Start your day off right with a delicious cup of coffee",
                                   starts_at: 1.year.ago,
                                   capacity: 111,
                                   image_file_name: "coffeecode.png" }

  let!(:event2) { Event.create name: "Hackathon",
                               location: "Austin",
                               price: 15.00,
                               description: "Hunker down at the Hackathon",
                               starts_at: 15.days.from_now,
                               capacity: 222,
                               image_file_name: "hackaton.png" }

  let!(:event3) { Event.create name: "Kata Camp",
                               location: "Dallas",
                               price: 75.00,
                               description: "Practice your craft kata style",
                               starts_at: 30.days.from_now,
                               capacity: 333,
                               image_file_name: "katacamp.png" }

  before { visit events_url }

  it "shows the upcoming events" do
    expect(page).to have_text "3 Events"
    expect(page).to have_text event1.name
    expect(page).to have_text event2.name
    expect(page).to have_text event3.name

    expect(page).to have_text event1.location
    expect(page).to have_text event1.description[0..10]
    expect(page).to have_text event1.starts_at
    expect(page).to have_text "$10.00"
    expect(page).to have_text event1.capacity
    expect(page).to have_selector "img[src$='#{event1.image_file_name}']"
  end

  it "does not show a past event" do
    expect(page).not_to have_text past_event.name
  end

  it "allows navigation to the event's detail page" do
    click_link event2.name

    expect(current_path).to eq event_path(event2)
  end
end
