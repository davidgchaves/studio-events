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
    expect(find_field("Capacity").value).to eq "1"
    expect(find_field("Image Filename").value).to eq nil
  end

  context "on success" do
    before do
      fill_in "Name", with: "Code and Coffee"
      fill_in "Description", with: "Sling some code with a cup o' Joe!"
      fill_in "Location", with: "Portland, OR"
      fill_in "Price", with: 0.00
      fill_in "Capacity", with: 50
      fill_in "Image Filename", with: "coffeecode.png"
      #select (10.days.from_now).to_s, from: "event_starts_at_1i"

      click_button "Create Event"
    end

    it "redirects to the detail page" do
      expect(current_path).to eq event_path(Event.last)
    end

    it "shows the new event's details" do
      expect(page).to have_text "Code and Coffee"
    end

    it "flashes an 'event successfully created' message" do
      expect(page).to have_text "Event successfully created!"
    end
  end

  context "on failure" do
    before do
      fill_in "Name", with: ""
      fill_in "Description", with: "Sling some code with a cup o' Joe!"

      click_button "Create Event"
    end

    it "renders again the new template" do
      expect(current_path).to eq events_path
      expect(page).to have_text "Create a New Event"
    end

    it "shows what was wrong last time" do
      expect(page).to have_text "correct the following"
    end

    it "preserves the event info entered the last time" do
      expect(page).to have_text "Sling some code with a cup o' Joe"
    end
  end
end
