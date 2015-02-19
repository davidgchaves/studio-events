require "rails_helper"
require "support/attributes"

describe Event do
  let(:event) { FactoryGirl.build :event }

  context "with factory attributes" do
    it "is valid" do
      expect(event).to be_valid
    end
  end

  context "with example attributes" do
    let(:event) { Event.new event_attributes }

    it "is valid" do
      expect(event).to be_valid
    end
  end

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

  describe "capacity" do
    it "is a positive integer number" do
      expect(subject).to validate_numericality_of(:capacity).
        is_greater_than(0).only_integer
    end
  end

  describe "image filename" do
    it "can be blank" do
      expect(subject).to allow_value("").for :image_file_name
    end

    context "when properly formatted" do
      let(:valid_file_names) { %w[e.png event.PnG event.jpg eVENT.GIF] }

      it "is valid" do
        valid_file_names.each do |valid_file_name|
          expect(subject).to allow_value(valid_file_name).for :image_file_name
        end
      end
    end

    context "when improperly formatted" do
      let(:invalid_file_names) { %w[event .png .jpg .gif event.pdf event.doc] }

      it "is invalid" do
        invalid_file_names.each do |invalid_file_name|
          expect(subject).not_to allow_value(invalid_file_name).for :image_file_name
        end
      end
    end
  end

  describe "is free?" do
    context "when costs $0" do
      let(:event) { Event.new price: 0 }

      it "is free" do
        expect(event).to be_free
      end
    end

    context "when has no price" do
      let(:event) { Event.new price: nil }

      it "is free" do
        expect(event).to be_free
      end
    end

    context "when has a price higher than $0" do
      let(:event) { Event.new price: 10.00 }

      it "is not free" do
        expect(event).not_to be_free
      end
    end
  end

  describe "is sold out?" do
    context "when there's no available spots" do
      let(:event) { FactoryGirl.create(:event, capacity: 3) }
      before(:example) { 3.times { event.registrations.create registration_attributes } }

      it "is sold out" do
        expect(event).to be_sold_out
      end
    end

    context "when there's available spots" do
      let(:event) { FactoryGirl.create(:event, capacity: 500) }
      before(:example) { 3.times { event.registrations.create registration_attributes } }

      it "is not sold out" do
        expect(event).not_to be_sold_out
      end
    end
  end

  context "upcoming query" do
    let(:past_event) { Event.create starts_at: 3.days.ago }
    let(:upcoming_event1) { FactoryGirl.create(:event, starts_at: 3.months.from_now) }
    let(:upcoming_event2) { FactoryGirl.create(:event, starts_at: 2.months.from_now) }
    let(:upcoming_event3) { FactoryGirl.create(:event, starts_at: 1.months.from_now) }

    it "only returns future events" do
      expect(Event.upcoming).to include upcoming_event1
    end

    it "never returns past events" do
      expect(Event.upcoming).not_to include past_event
    end

    it "returns upcoming events ordered with the most recently-upcoming event first" do
      expect(Event.upcoming).to eq [upcoming_event3, upcoming_event2, upcoming_event1]
    end
  end

  it "calculates the available spots" do
    event = FactoryGirl.create(:event, capacity: 5)
    3.times { event.registrations.create registration_attributes }

    expect(event.spots_left).to eq 5-3
  end
end
