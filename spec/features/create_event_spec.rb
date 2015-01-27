require "rails_helper"

describe "Creating a new event" do
  before do
    visit events_url
    click_link "Add New Event"
  end

  it "goes to the create page" do
    expect(current_path).to eq new_event_path
  end

  it "shows the form to create events" do
    expect(find_field("Name").value).to eq nil
    expect(find_field("Location").value).to eq nil
    expect(find_field("Price").value).to eq nil
  end

  context "when done" do
    before do
      fill_in "Name", with: "Code and Coffee"
      fill_in "Description", with: "Sling some code with a cup o' Joe!"
      fill_in "Location", with: "Portland, OR"
      fill_in "Price", with: 0.00
      #select (10.days.from_now).to_s, from: "event_starts_at_1i"

      click_button "Create Event"
    end

    it "redirects to the detail page" do
      expect(current_path).to eq event_path(Event.last)
    end

    it "shows the new event's details" do
      expect(page).to have_text "Code and Coffee"
    end
  end
end
