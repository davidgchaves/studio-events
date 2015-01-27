require "rails_helper"
require "support/attributes"

describe "Editing an event" do
  let!(:event) { Event.create event_attributes }

  before do
    visit event_url(event)
    click_link "Edit"
  end

  it "goes to the edit page" do
    expect(current_path).to eq edit_event_path(event)
  end

  it "shows the form to edit events" do
    expect(find_field('Name').value).to eq event.name
  end

  context "when done" do
    before do
      fill_in "Name", with: "Updated Event Name"
      click_button "Update Event"
    end

    it "redirects to the detail page" do
      expect(current_path).to eq event_path(event)
    end

    it "shows the event's updated details" do
      expect(page).to have_text "Updated Event Name"
    end
  end
end
