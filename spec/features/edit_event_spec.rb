require "rails_helper"
require "support/attributes"

describe "Editing an event" do
  it "shows the form to edit events" do
    event = Event.create event_attributes
    visit event_url(event)

    click_link "Edit"

    expect(find_field('Name').value).to eq event.name
  end
end
