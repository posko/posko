require 'rails_helper'

RSpec.describe UserRole, type: :model do
  let(:user_role) { create(:user_role) }
  describe "Factory" do
    it "creates necessary data" do
  		expect(user_role).to be_present
  		expect(Role.count).to eq(1)
    end
	end
	describe "Associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:role) }
	end
end
