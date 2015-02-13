require 'rails_helper'

describe User do
  context "invalid when" do
    it "has a blank name" do
      user = User.new name: ""

      user.valid?

      expect(user.errors[:name].any?).to be_truthy
    end

    it "has a blank email" do
      user = User.new email: ""

      user.valid?

      expect(user.errors[:email].any?).to be_truthy
    end
  end

  context "email" do
    it "accepts properly formatted emails" do
      valid_emails = ["moe.sTOO@stoogies.com", "moe.sTOO@st.o.gies.com"]
      valid_emails.each do |valid_email|
        valid_user = User.new email: valid_email

        valid_user.valid?

        expect(valid_user.errors[:email].any?).to be_falsy
      end
    end

    it "rejects improperly formatted emails" do
      invalid_emails = ["@", "moe stoo@stoogies.com", "moe.stoo@sto ogies.com"]
      invalid_emails.each do |invalid_email|
        invalid_user = User.new email: invalid_email

        invalid_user.valid?

        expect(invalid_user.errors[:email].any?).to be_truthy
      end
    end
  end
end
