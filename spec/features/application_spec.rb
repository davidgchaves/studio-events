require "rails_helper"

describe "The flash" do
  it "is not shown with an empty notice message" do
    visit events_url

    expect(page).not_to have_css "p.flash.notice"
  end
end
