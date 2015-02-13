require 'rails_helper'

describe User do
  context "invalid when" do
    it "has a blank name" do
      user = User.new name: ""

      user.valid?

      expect(user.errors[:name].any?).to be_truthy
    end
  end
end