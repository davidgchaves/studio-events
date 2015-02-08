require 'rails_helper'
require 'support/attributes'

describe "A registration" do
  it "belongs to an event" do
    event = Event.create event_attributes

    registration = event.registrations.new name: "Moe", email: "moe@stoogies.com", how_heard: "Internet"

    expect(registration.event).to eq event
  end
end

