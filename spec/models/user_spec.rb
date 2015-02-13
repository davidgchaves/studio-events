require 'rails_helper'
require 'support/attributes'

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

    it "requires to be unique and case insensitive" do
      user1 = User.create user_attributes
      user2 = User.new email: user1.email.upcase

      user2.valid?

      expect(user2.errors[:email].any?).to be_truthy
    end
  end

  context "password" do
    it "can't be empty" do
      invalid_user = User.new password: ""

      invalid_user.valid?

      expect(invalid_user.errors[:password].any?).to be_truthy
    end

    context "when present" do
      it "is automatically encrypted into the password_digest attribute" do
        user = User.new password: "secret"

        expect(user.password_digest.present?).to be_truthy

      end

      it "has to match the password confirmation" do
        invalid_user = User.new password: "secret", password_confirmation: "nomatch"

        invalid_user.valid?

        expect(invalid_user.errors[:password_confirmation]).to eq ["doesn't match Password"]
      end
    end
  end

  context "with example attributes" do
    it "is valid" do
      user = User.new user_attributes

      expect(user.valid?).to be_truthy
    end
  end
end
