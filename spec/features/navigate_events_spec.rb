require "rails_helper"
require "support/attributes"

describe "Navigating events" do
  let!(:event) { Event.create event_attributes }

  it "allows navigation from the detail page to the listing page" do
    visit event_url(event)

    click_link "All Events"

    expect(current_path).to eq events_path
  end

  it "allows navigation from the listing page to the detail page" do
    visit events_url

    click_link event.name

    expect(current_path).to eq event_path(event)
  end

  it "allows navigation from the detail page to the edit page" do
    visit event_url(event)

    click_link "Edit"

    expect(current_path).to eq edit_event_path(event)
  end

  it "allows navigation from the edit page to the detail page" do
    visit event_url(event)
    click_link "Edit"

    click_button "Update Event"

    expect(current_path).to eq event_path(event)
  end
end
