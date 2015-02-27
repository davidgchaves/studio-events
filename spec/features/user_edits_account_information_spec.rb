require "rails_helper"

feature "User edits account information" do
  scenario "successfully" do
    larry = FactoryGirl.create :user, email: "calm_larry@example.com"
    visit user_path(larry)

    click_on "Edit Account"

    fill_in "Email", with: "MAD_LARRY@example.com"
    click_on "Update Account"

    expect(page).to have_css "#wrapper p.notice", text: "Account successfully updated!"
    expect(page).to have_css "#users h2", text: "MAD_LARRY@example.com"
    expect(page).not_to have_css "#users h2", text: "calm_larry@example.com"
  end

  scenario "unsuccessfully" do
    larry = FactoryGirl.create :user
    visit user_path(larry)

    click_on "Edit Account"

    fill_in "Email", with: ""
    click_on "Update Account"

    expect(page).to have_css "#errors h2", text: "The user could not be saved"
    expect(page).to have_css "li.required .field_with_errors label", text: "Email"
  end
end
