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

  context "on success" do
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

  context "on failure" do
    before do
      fill_in "Name", with: ""
      fill_in "Description", with: "Sling some code with a cup o' Joe!"

      click_button "Update Event"
    end

    it "renders again the edit page" do
      expect(current_path).to eq event_path(event)
    end

    it "shows what was wrong last time" do
      expect(page).to have_text "correct the following"
    end

    it "preserves the event info entered the last time" do
      expect(page).to have_text "Sling some code with a cup o' Joe"
    end
  end
end
