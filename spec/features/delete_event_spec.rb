require "rails_helper"
require "support/attributes"

describe "Deleting an event" do
  it "shows the event listing without the deleted event" do
    event = Event.create event_attributes
    visit event_url(event)

    click_link "Delete"

    expect(page).not_to have_text event.name
    expect(page).not_to have_text event.description
  end
end
