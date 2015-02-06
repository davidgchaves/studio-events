require "rails_helper"
require "support/attributes"

describe "Deleting an event" do
  let!(:event) { Event.create event_attributes }

  before do
    visit event_url(event)
    click_link "Delete"
  end

  it "redirects to the listing page destroying the event" do
    expect(current_path).to eq events_path
  end

  it "shows the event listing without the deleted event" do
    expect(page).not_to have_text event.name
    expect(page).not_to have_text event.description
  end

  it "flashes an 'event successfully deleted' message" do
    expect(page).to have_text "Event successfully deleted!"
  end
end
