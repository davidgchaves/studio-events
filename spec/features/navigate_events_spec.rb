require "rails_helper"
require "support/attributes"

describe "Navigating events" do
  let!(:event) { Event.create event_attributes }

  it "allows navigation from the detail page to the listing page destroying an event" do
    visit event_url(event)

    click_link "Delete"

    expect(current_path).to eq events_path
  end
end
