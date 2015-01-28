require "rails_helper"
require "support/attributes"

describe "Viewing the list of events" do
  let!(:event1) { Event.create name: "BugSmash",
                               location: "Denver",
                               price: 10.00,
                               description: "A fun evening of bug smashing",
                               starts_at: 10.days.from_now }

  let!(:past_event) { Event.create name: "Coffee and Code",
                                   location: "Stumpron Coffee, Portland",
                                   price: 0.00,
                                   description: "Start your day off right with a delicious cup of coffee",
                                   starts_at: 1.year.ago }

  let!(:event2) { Event.create name: "Hackathon",
                               location: "Austin",
                               price: 15.00,
                               description: "Hunker down at the Hackathon",
                               starts_at: 15.days.from_now }

  let!(:event3) { Event.create name: "Kata Camp",
                               location: "Dallas",
                               price: 75.00,
                               description: "Practice your craft kata style",
                               starts_at: 30.days.from_now }

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
  end

  it "does not show a past event" do
    expect(page).not_to have_text past_event.name
  end

  it "allows navigation to the event's detail page" do
    click_link event2.name

    expect(current_path).to eq event_path(event2)
  end
end
