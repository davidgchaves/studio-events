require "rails_helper"
require "support/attributes"

describe Event do
  it "has many (destroy dependent) registrations" do
    expect(subject).to have_many(:registrations).dependent :destroy
  end

  describe "name" do
    it "can't be blank" do
      expect(subject).to validate_presence_of :name
    end
  end

  describe "location" do
    it "can't be blank" do
      expect(subject).to validate_presence_of :location
    end
  end

  describe "description" do
    it "contains at least 25 characters" do
      expect(subject).to validate_length_of(:description).is_at_least 25
    end
  end

  describe "price" do
    it "is $0 or higher" do
      expect(subject).to validate_numericality_of(:price).is_greater_than_or_equal_to 0
    end
  end

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

  context "requires a capacity that" do
    it "is an integer number" do
      event = Event.new capacity: -3.0

      event.valid?

      expect(event.errors[:capacity].any?).to eq true
    end

    it "is a positive number" do
      event = Event.new capacity: 0

      event.valid?

      expect(event.errors[:capacity].any?).to eq true
    end
  end

  it "accepts a blank image filename" do
    event = Event.new image_file_name: ""

    event.valid?

    expect(event.errors[:image_file_name].any?).to eq false
  end

  it "accepts properly formatted image file names" do
    file_names = %w[e.png event.PnG event.jpg eVENT.GIF]
    file_names.each do |file_name|
      event = Event.new image_file_name: file_name

      event.valid?

      expect(event.errors[:image_file_name].any?).to eq false
    end
  end

  it "rejects improperly formatted image file names" do
    file_names = %w[event .png .jpg .gif event.pdf event.doc]
    file_names.each do |file_name|
      event = Event.new image_file_name: file_name

      event.valid?

      expect(event.errors[:image_file_name].any?).to eq true
    end
  end

  it "is valid with example attributes" do
    event = Event.new event_attributes

    expect(event.valid?).to eq true
  end

  it "calculates the available spots" do
    event = Event.create event_attributes(capacity: 5)
    3.times { event.registrations.create registration_attributes }

    expect(event.spots_left).to eq 5-3
  end

  it "is sold out if there's no available spots" do
    event = Event.create event_attributes(capacity: 3)
    3.times { event.registrations.create registration_attributes }

    expect(event).to be_sold_out
  end

  it "is not sold out if there's available spots" do
    event = Event.create event_attributes(capacity: 500)
    3.times { event.registrations.create registration_attributes }

    expect(event).not_to be_sold_out
  end
end
