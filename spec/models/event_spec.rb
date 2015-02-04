require "rails_helper"
require "support/attributes"

describe "An event" do
  it "is free if the price is $0" do
    event = Event.new price: 0

    expect(event.free?).to eq true
  end

  it "is free if the price is blank" do
    event = Event.new price: nil

    expect(event.free?).to eq true
  end

  it "is not free if the price is non-$0" do
    event = Event.new price: 10.00

    expect(event.free?).to eq false
  end

  it "is upcoming if the starts at date is in the future" do
    event = Event.create event_attributes(starts_at: 3.days.from_now)

    expect(Event.upcoming).to include event
  end

  it "is not upcoming if the starts at date is in the past" do
    event = Event.create starts_at: 3.days.ago

    expect(Event.upcoming).not_to include event
  end

  it "returns upcoming events ordered with the most recently-upcoming event first" do
    event1 = Event.create event_attributes(starts_at: 3.months.from_now)
    event2 = Event.create event_attributes(starts_at: 2.months.from_now)
    event3 = Event.create event_attributes(starts_at: 1.months.from_now)

    expect(Event.upcoming).to eq [event3, event2, event1]
  end

  it "requires a name" do
    event = Event.new name: ""

    event.valid?

    expect(event.errors[:name].any?).to eq true
  end

  it "requires a description" do
    event = Event.new description: ""

    event.valid?

    expect(event.errors[:description].any?).to eq true
  end

  it "requires a location" do
    event = Event.new location: ""

    event.valid?

    expect(event.errors[:location].any?).to eq true
  end
end
