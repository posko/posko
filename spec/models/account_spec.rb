require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) { create(:account, name: "first_company", company: "First Company") }
  describe "Account creation" do
    it "creates new account" do
      account = Account.create name: "first_company", company: "First Company"
      expect(account).to be_truthy
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:products) }
    it { is_expected.to have_many(:variants).through(:products) }
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:order_lines).through(:orders) }
    it { is_expected.to have_many(:customers) }
    it { is_expected.to have_many(:roles) }
    it { is_expected.to have_many(:users) }
  end
end
