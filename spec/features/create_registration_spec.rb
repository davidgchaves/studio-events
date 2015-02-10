require 'rails_helper'
require 'support/attributes'

describe "Creating a new registration for an event" do
  it "goes to the create event's registration page" do
    event = Event.create event_attributes
    visit event_url(event)

    click_link "Register!"

    expect(current_path).to eq new_event_registration_path(event)
  end

  it "shows a header with the event for which we are registering" do
    event = Event.create event_attributes
    visit event_url(event)

    click_link "Register!"

    expect(page).to have_text event.name
  end
end
