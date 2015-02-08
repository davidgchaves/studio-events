require 'rails_helper'
require 'support/attributes'

describe "A registration" do
  it "belongs to an event" do
    event = Event.create event_attributes

    registration = event.registrations.new registration_attributes

    expect(registration.event).to eq event
  end

  it "requires a name" do
    invalid_registration = Registration.new name: ""

    invalid_registration.valid?

    expect(invalid_registration.errors[:name].any?).to eq true
  end

  it "accepts properly formatted emails" do
    valid_emails = ["moe.sTOO@stoogies.com", "moe.sTOO@st.o.gies.com"]

    valid_emails.each do |valid_email|
      valid_registration = Registration.new email: valid_email

      valid_registration.valid?

      expect(valid_registration.errors[:email].any?).to eq false
    end
  end

  it "rejects improperly formatted emails" do
    invalid_emails = ["@", "moe stoo@stoogies.com", "moe.stoo@sto ogies.com"]

    invalid_emails.each do |invalid_email|
      invalid_registration = Registration.new email: invalid_email

      invalid_registration.valid?

      expect(invalid_registration.errors[:email].any?).to eq true
    end
  end
end

