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

  it "allows navigation from the listing page to the create page" do
    visit events_url

    click_link "Add New Event"

    expect(current_path).to eq new_event_path
  end

  it "allows navigation from the create page to the detail page" do
    visit events_url
    click_link "Add New Event"
    fill_in "Name", with: "Code and Coffee"
    fill_in "Description", with: "Sling some code with a cup o' Joe!"
    fill_in "Location", with: "Portland, OR"
    fill_in "Price", with: 0.00
    #select (10.days.from_now).to_s, from: "event_starts_at_1i"

    click_button "Create Event"

    expect(current_path).to eq event_path(Event.last)
  end

  it "allows navigation from the detail page to the listing page destroying an event" do
    visit event_url(event)

    click_link "Delete"

    expect(current_path).to eq events_path
  end
end
