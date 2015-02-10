require "rails_helper"

describe "Viewing the list of events" do
  let!(:event1) { Event.create event_attributes(name: "BugSmash") }
  let!(:event2) { Event.create event_attributes(name: "Hackathon") }
  let!(:event3) { Event.create event_attributes(name: "Kata Camp") }
  let!(:past_event) { Event.create event_attributes(name: "Coffee and Code", starts_at: 1.year.ago) }

  it "shows the upcoming events" do
    visit events_url

    expect(page).to have_text "Events"
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
    visit events_url

    expect(page).not_to have_text past_event.name
  end

  it "allows navigation to the event's detail page" do
    visit events_url

    click_link event2.name

    expect(current_path).to eq event_path(event2)
  end
end
