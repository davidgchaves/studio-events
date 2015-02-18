require 'rails_helper'
require 'support/attributes'

describe User do
  describe "name" do
    it "can't be empty" do
      expect(subject).to validate_presence_of :name
    end
  end

  describe "email" do
    it "can't be empty" do
      expect(subject).to validate_presence_of :email
    end

    context "when properly formatted" do
      let(:valid_emails) { ["moe.sTOO@stoogies.com", "moe.sTOO@st.o.gies.com"] }

      it "is valid" do
        valid_emails.each do |valid_email|
          expect(subject).to allow_value(valid_email).for :email
        end
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
      valid_user = User.create user_attributes
      invalid_user = User.new email: valid_user.email.upcase

      invalid_user.valid?

      expect(invalid_user.errors[:email].any?).to be_truthy
    end
  end

  describe "password" do
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
      expect(User.new user_attributes).to be_valid
    end
  end

  context "with factory attributes" do
    it "is valid" do
      expect(FactoryGirl.build :user).to be_valid
    end
  end
end
