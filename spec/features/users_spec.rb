require 'rails_helper'

feature "Viewing the list of users" do
  scenario "shows the users" do
    larry = FactoryGirl.create :user, name: "Larry"
    moe = FactoryGirl.create :user, name: "Moe"
    curly = FactoryGirl.create :user, name: "Curly"

    visit users_url

    within "#content-header" do
      expect(page).to have_text "3 Users"
    end

    within "#users" do
      expect(page).to have_link larry.name
      expect(page).to have_link moe.name
      expect(page).to have_link curly.name
    end
  end
end