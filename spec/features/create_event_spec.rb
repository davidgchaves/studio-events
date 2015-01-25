require "rails_helper"

describe "Creating a new event" do
  it "shows the form to create events" do
    visit events_url

    click_link "Add New Event"

    expect(find_field("Name").value).to eq nil
    expect(find_field("Location").value).to eq nil
    expect(find_field("Price").value).to eq nil
  end
end
