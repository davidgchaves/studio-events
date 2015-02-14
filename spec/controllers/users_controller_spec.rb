require 'rails_helper'

describe UsersController do

  describe "GET #index" do
    it "populates an array of all users" do
      larry = FactoryGirl.create :user, name: "Larry"
      moe = FactoryGirl.create :user, name: "Moe"

      get :index

      expect(assigns :users).to match_array [larry, moe]
    end

    it "renders the :index template" do
      get :index

      expect(response).to render_template :index
    end
  end
end
