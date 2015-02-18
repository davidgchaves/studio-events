require 'rails_helper'
require 'support/attributes'

describe Registration do
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

  it "rejects any how heard description that is not in the predetermined list" do
    invalid_how_heards = %w[Internet Facebook Whatever]
    invalid_how_heards.each do |invalid_how_heard|
      invalid_registration = Registration.new how_heard: invalid_how_heard

      invalid_registration.valid?

      expect(invalid_registration.errors[:how_heard].any?).to eq true
    end
  end

  it "accepts any how heard description that is in the predetermined list" do
    valid_how_heards = ["Newsletter", "Blog Post", "Twitter", "Web Search", "Friends/Coworker", "Other"]
    valid_how_heards.each do |valid_how_heard|
      valid_registration = Registration.new how_heard: valid_how_heard

      valid_registration.valid?

      expect(valid_registration.errors[:how_heard].any?).to eq false
    end
  end

  it "is valid with example attributes" do
    registration = Registration.new registration_attributes

    expect(registration.valid?).to eq true
  end
end

