require 'rails_helper'

describe UsersController do

  describe "GET #index" do
    let(:larry) { FactoryGirl.create :user, name: "Larry" }
    let(:moe) { FactoryGirl.create :user, name: "Moe" }
    before(:example) { get :index }

    it "populates an array of all users" do
      expect(assigns :users).to match_array [larry, moe]
    end

    it "renders the :index template" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    let(:larry) { FactoryGirl.create :user, name: "Larry" }
    before(:example) { get :show, id: larry }

    it "assigns the requested user" do
      expect(assigns :user).to eq larry
    end

    it "renders the :show template" do
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    before(:example) { get :new }

    it "assigns a new user" do
      expect(assigns :user).to be_a_new User
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with a valid user" do
      let(:valid_user) { FactoryGirl.attributes_for :user }

      it "saves the new user to the database" do
        expect{ post :create, user: valid_user }.to change(User, :count).by 1
      end

      it "redirects to users#show" do
        post :create, user: valid_user

        expect(response).to redirect_to user_path(assigns :user)
      end
    end

    context "with an invalid user" do
      let(:invalid_user) { FactoryGirl.attributes_for :invalid_user }

      it "does not save the new user to the database" do
        expect{ post :create, user: invalid_user }.not_to change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, user: invalid_user

        expect(response).to render_template :new
      end
    end
  end
end
