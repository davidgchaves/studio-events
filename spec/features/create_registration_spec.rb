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

  it "shows the form to create an event's registration" do
    expect(find_field("Name").value).to eq nil
    expect(find_field("Email").value).to eq nil
    expect(find_field("How heard").visible?).to eq true
    expect(find_button("Create Registration").visible?).to eq true
    expect(find_link("Cancel").visible?).to eq true
  end

  context "on success" do
    before do
      fill_in "Name", with: "Larry"
      fill_in "Email", with: "larry@stooges.com"
      select "Twitter", from: "How heard"

      click_button "Create Registration"
    end

    it "redirects to the registration's listing page for that event" do
      expect(current_path).to eq event_registrations_path(event)
    end

    it "shows the new registration's details" do
      expect(page).to have_text "Larry"
      expect(page).to have_text "Twitter"
    end
  end
end
