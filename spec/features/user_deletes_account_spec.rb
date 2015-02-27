require "rails_helper"

feature "User deletes account" do
  scenario "successfully" do
    larry = FactoryGirl.create :user
    visit user_path(larry)

    click_on "Delete Account"

    expect(page).to have_css "#wrapper p.alert", text: "Account successfully deleted!"

    visit users_path
    expect(page).to have_css "#content h1", text: "0 Users"
  end
end
