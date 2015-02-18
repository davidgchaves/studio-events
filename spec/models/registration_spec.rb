require 'rails_helper'
require 'support/attributes'

describe Registration do
  let(:registration) { FactoryGirl.build :registration }

  context "with factory attributes" do
    it "is valid" do
      expect(registration).to be_valid
    end
  end

  it "belongs to an event" do
    expect(subject).to belong_to :event
  end

  describe "name" do
    it "can't be blank" do
      expect(subject).to validate_presence_of :name
    end
  end

  describe "email" do
    context "when properly formatted" do
      let(:valid_emails) { ["moe.sTOO@stoogies.com", "moe.sTOO@st.o.gies.com"] }

      it "is valid" do
        valid_emails.each do |valid_email|
          expect(subject).to allow_value(valid_email).for :email
        end
      end
    end

    context "when improperly formatted" do
      let(:invalid_emails) { ["@", "moe stoo@stoogies.com", "moe.stoo@sto ogies.com"] }

      it "is invalid" do
        invalid_emails.each do |invalid_email|
          expect(subject).not_to allow_value(invalid_email).for :email
        end
      end
    end
  end

  describe "how heard" do
    let(:valid_how_heards) { ["Newsletter", "Blog Post", "Twitter", "Web Search", "Friends/Coworker", "Other"] }

    it "is picked from a list of valid values" do
      expect(subject).to validate_inclusion_of(:how_heard).in_array valid_how_heards
    end
  end

  it "is valid with example attributes" do
    registration = Registration.new registration_attributes

    expect(registration.valid?).to eq true
  end
end

