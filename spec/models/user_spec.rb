require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, password: "mypassword", first_name: "Juan", last_name: "Dela Cruz", suffix: "Sr.") }
  describe "bcrypt" do
    it { is_expected.to have_secure_password }
  end

  # describe "instance methods" do
  # end

  describe "validations" do
    subject { user }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to allow_value("a.a@a.com").for(:email) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:account) }
    it { is_expected.to have_many(:user_roles) }
    it { is_expected.to have_many(:roles).through(:user_roles) }
    it { is_expected.to have_many(:access_keys) }
  end
end
