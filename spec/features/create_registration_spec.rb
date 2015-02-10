require 'rails_helper'
require 'support/attributes'

describe "Creating a new registration for an event" do
  let(:event) { Event.create event_attributes }

  before do
    visit event_url(event)
    click_link "Register!"
  end

  it "goes to the create event's registration page" do
    expect(current_path).to eq new_event_registration_path(event)
  end

  it "shows a header with the event for which we are registering" do
    expect(page).to have_text event.name
  end
end
