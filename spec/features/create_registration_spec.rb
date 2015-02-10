require 'rails_helper'
require 'support/attributes'

describe "Creating a new registration for an event" do
  it "goes to the create event's registration page" do
    event = Event.create event_attributes
    visit event_url(event)

    click_link "Register!"

    expect(current_path).to eq new_event_registration_path(event)
  end
end
