require "rails_helper"

describe "Viewing the list of events" do
  it "shows the event" do
    visit events_url

    expect(page).to have_text "3 Events"
    expect(page).to have_text "BugSmash"
    expect(page).to have_text "Hackathon"
    expect(page).to have_text "Kata Camp"
  end
end
