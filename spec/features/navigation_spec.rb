require "rails_helper"
require "support/attributes"

describe "The sidebar" do
  before do
    event = Event.create event_attributes
    visit event_url(event)
  end

  it "allows direct navigation to the listing page" do
    click_link "All Events"

    expect(current_path).to eq events_path
  end

  it "allows direct navigation to the create event page" do
    click_link "Add New Event"

    expect(current_path).to eq new_event_path
  end
end
