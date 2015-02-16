require "rails_helper"
require "support/attributes"

describe "Viewing an individual event" do

  it "shows the event's details" do
    event = Event.create event_attributes

    visit event_url(event)

    expect(page).to have_text event.name
    expect(page).to have_text event.location
    expect(page).to have_text event.description
    expect(page).to have_text event.starts_at
    expect(page).to have_text event.capacity
    expect(page).to have_text "#{event.capacity} spots available"
    # expect(page).to have_selector "img[src$='#{event.image_file_name}']"
  end

  it "shows the price if the price is not $0" do
    event = Event.create event_attributes(price: 20.00)

    visit event_url(event)

    expect(page).to have_text "$20.00"
  end

  it "shows 'Free' if the price is $0" do
    free_event = Event.create event_attributes(price: 0)

    visit event_url(free_event)

    expect(page).to have_text "Free"
  end

  it "shows the event image when there's an image associated to the event" do
    event_with_image = Event.create event_attributes(image_file_name: "coffeecode.png")

    visit event_url(event_with_image)

    expect(page).to have_selector "img[src$='#{event_with_image.image_file_name}']"
  end

  it "shows a default image when there's no image associated to the event" do
    event_with_no_image = Event.create event_attributes(image_file_name: "")

    visit event_url(event_with_no_image)

    expect(page).to have_selector "img[src$='placeholder.png']"
  end

  it "allows navigation to the associated registrations" do
    event = Event.create event_attributes
    visit event_url(event)

    click_link "Who's Registered?"

    expect(current_path).to eq event_registrations_path(event)
  end

  it "shows a registration link when there's available spots" do
    event = Event.create event_attributes(capacity: 5)
    2.times { event.registrations.create registration_attributes }

    visit event_url(event)

    expect(page).to have_link "Register!"
  end

  context "when is sold out" do
    let(:event) { Event.create event_attributes(capacity: 3) }

    before(:example) do
      3.times { event.registrations.create registration_attributes }

      visit event_url(event)
    end

    it "doesn't show a registration link" do
      expect(page).not_to have_link "Register!"
    end

    it "shows a 'Sold Out!' message" do
      expect(page).to have_text "Sold Out!"
    end
  end
end
