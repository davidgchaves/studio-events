require "rails_helper"
require "support/attributes"

describe "Editing an event" do
  it "shows the form to edit events" do
    event = Event.create event_attributes
    visit event_url(event)

    click_link "Edit"

    expect(find_field('Name').value).to eq event.name
  end

  it "shows the event's updated details" do
    event = Event.create event_attributes
    visit event_url(event)
    click_link "Edit"
    fill_in "Name", with: "Updated Event Name"

    click_button "Update Event"

    expect(page).to have_text "Updated Event Name"
  end
end
