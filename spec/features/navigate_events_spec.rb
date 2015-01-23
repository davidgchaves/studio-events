require "rails_helper"

describe "Navigating events" do

  it "allows navigation from the detail page to the listing page" do
    event = Event.create name: "BugSmash",
                         location: "Denver",
                         price: 10.00,
                         description: "A fun evening of bug smashing",
                         starts_at: 10.days.from_now
    visit event_url(event)

    click_link "All Events"

    expect(current_path).to eq events_path
  end

  it "allows navigation from the listing page to the detail page" do
    event = Event.create name: "BugSmash",
                         location: "Denver",
                         price: 10.00,
                         description: "A fun evening of bug smashing",
                         starts_at: 10.days.from_now
    visit events_url

    click_link event.name

    expect(current_path).to eq event_path(event)
  end
end
