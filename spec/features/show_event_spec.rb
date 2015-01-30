require "rails_helper"
require "support/attributes"

describe "Viewing an individual event" do
  let! (:event) { Event.create event_attributes }

  it "shows the event's details" do
    visit event_url(event)

    expect(page).to have_text event.name
    expect(page).to have_text event.location
    expect(page).to have_text event.description
    expect(page).to have_text event.starts_at
    expect(page).to have_text event.capacity
    expect(page).to have_selector "img[src$='#{event.image_file_name}']"
  end

  it "shows the price if the price is not $0" do
    event = Event.create event_attributes(price: 20.00)

    visit event_url(event)

    expect(page).to have_text "$20.00"
  end

  it "shows 'Free' if the price is $0" do
    event = Event.create event_attributes(price: 0)

    visit event_url(event)

    expect(page).to have_text "Free"
  end

  it "allows navigation to the listing page" do
    visit event_url(event)

    click_link "All Events"

    expect(current_path).to eq events_path
  end
end
