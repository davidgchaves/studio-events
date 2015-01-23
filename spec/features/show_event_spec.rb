require "rails_helper"
require "support/attributes"

describe "Viewing an individual event" do
  it "shows the event's details" do
    event = Event.create event_attributes(price: 10.00)

    visit event_url(event)

    expect(page).to have_text event.name
    expect(page).to have_text event.location
    expect(page).to have_text "$10.00"
    expect(page).to have_text event.description
    expect(page).to have_text event.starts_at
  end
end
