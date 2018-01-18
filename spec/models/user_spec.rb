require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, password: "mypassword") }
  describe ".authenticate" do
    context "with correct password" do
      it { expect(user.authenticate "mypassword").to be_truthy }
    end
    context "with incorrect password" do
      it { expect(user.authenticate "wrongpass").to be_falsey }
    end
  end
  describe "validations" do
    subject { user }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to allow_value("a.a@a.com").for(:email) }
  end
  describe "associations" do
    it { expect(user).to belong_to(:account) }
    it { expect(user).to have_many(:user_roles) }
    it { expect(user).to have_many(:roles).through(:user_roles) }
  end
end
