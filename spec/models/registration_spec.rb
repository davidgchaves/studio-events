require 'rails_helper'
require 'support/attributes'

describe "A registration" do
  it "belongs to an event" do
    event = Event.create event_attributes

    registration = event.registrations.new registration_attributes

    expect(registration.event).to eq event
  end
end

