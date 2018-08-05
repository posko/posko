require 'rails_helper'

RSpec.describe RegistrationService do
  let(:registration_service) do
    RegistrationService.new account_name: "newcompany", company: "New Company", email: "ceo@new_company.com", password: "mypassword",
               first_name: "Juan", last_name: "Dela Cruz"
  end
  describe '#perform' do
    it "creates a new account and user" do
      # maybe I should store record counts before processing in case of leakage
      expect(registration_service.perform).to be_truthy
      expect(Account.count).to eq(1)
      expect(Account.first.users.count).to eq(1)
    end
    it "rejects a invalid credential" do
      # maybe I should store record counts before processing in case of leakage
      expect(Account.count).to eq(0)
      expect(User.count).to eq(0)
      expect(registration_service.perform).to be_truthy
      expect{registration_service.deep_dup.perform}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#user' do
    before do
      registration_service.perform
    end
    subject { registration_service.user }
    it { is_expected.to be_truthy }
  end

  describe '#account' do
    subject { -> { registration_service.account } }
    context "when processed" do
      before { registration_service.perform }
      it { is_expected.to be_truthy }
    end
  end

  describe '#processed?' do
    subject { registration_service.performed? }
    context "when processed" do
      before { registration_service.perform }
      it { is_expected.to be_truthy }
    end
    context "when not yet processed" do
      it { is_expected.to be_falsey }
    end
  end
end
